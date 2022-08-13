import '../../core/either.dart';
import '../../core/failure.dart';
import '../../core/use_case.dart';
import '../../domain/entities/city.dart';
import '../../domain/repos/city_repo.dart';
import 'package:riverpod/riverpod.dart';

class GetCity implements UseCase<City, NoParams> {
  const GetCity(this.repo);

  final CityRepo repo;

  @override
  Future<Either<Failure, City>> call(NoParams params) => repo.getCity();
}

final getCityProvider = Provider((ref) => GetCity(ref.watch(cityRepoProvider)));
