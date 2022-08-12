import '../../core/either.dart';
import '../../core/failure.dart';
import '../../data/data_sources/city_local_data_source.dart';
import '../../data/data_sources/city_random_data_source.dart';
import '../../data/models/city_model.dart';
import '../../data/repos/geocoding_repo.dart';
import '../../domain/entities/city.dart';
import '../../domain/repos/city_repo.dart';
import 'package:riverpod/riverpod.dart';

class CityRepoImpl implements CityRepo {
  CityRepoImpl({
    required this.localDataSource,
    required this.randomDataSource,
    required this.geocodingRepo,
  });

  final CityLocalDataSource localDataSource;

  final CityRandomDataSource randomDataSource;

  final GeocodingRepo geocodingRepo;

  @override
  Future<Either<Failure, City>> getCity() async {
    final cityEither = await localDataSource.getCity();

    if (cityEither is Left) {
      return cityEither.map((model) => model!.city);
    }

    final cityModel = (cityEither as Right<Failure, CityModel?>).value;

    if (cityModel == null) {
      return (await randomDataSource.getCity()).map((model) => model.city);
    }

    return Right(cityModel.city);
  }

  @override
  Future<Either<Failure, void>> setCity(City city) async {
    final coordinates = await geocodingRepo.getCoordinates(city);

    return coordinates.fold(
      (failure) async => Left(failure),
      (coordinates) => localDataSource.setCity(coordinates.city),
    );
  }
}

final cityRepoImplProvider = Provider(
  (ref) => CityRepoImpl(
    localDataSource: ref.watch(cityLocalDataSourceProvider),
    randomDataSource: ref.watch(cityRandomDataSourceProvider),
    geocodingRepo: ref.watch(geocodingRepoProvider),
  ),
);
