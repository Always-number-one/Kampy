import '../../core/either.dart';
import '../../core/failure.dart';
import '../../data/data_sources/geocoding_caching_data_source.dart';
import '../../data/data_sources/geocoding_remote_data_source.dart';
import '../../data/models/geographic_coordinates_model.dart';
import '../../domain/entities/city.dart';
import 'package:riverpod/riverpod.dart';

class GeocodingRepo {
  GeocodingRepo(
    this._geocodingRemoteDataSource,
    this._geocodingCachingDataSource,
  );

  final GeocodingRemoteDataSource _geocodingRemoteDataSource;

  final GeocodingCachingDataSource _geocodingCachingDataSource;

  Future<Either<Failure, GeographicCoordinatesModel>> getCoordinates(
    City city,
  ) async {
    final cachedCoordinates =
        await _geocodingCachingDataSource.getCachedCoordinates(city);

    if (cachedCoordinates is Left ||
        cachedCoordinates.all((coordinates) => coordinates != null)) {
      return cachedCoordinates.map((coordinates) => coordinates!);
    }

    final coordinates = await _geocodingRemoteDataSource.getCoordinates(city);

    await coordinates
        .map<Future<void>>(
          (coordinates) => _geocodingCachingDataSource.setCachedCoordinates(
            city,
            coordinates,
          ),
        )
        .getOrElse(() async {});

    return coordinates;
  }
}

final geocodingRepoProvider = Provider(
  (ref) => GeocodingRepo(
    ref.watch(geocodingRemoteDataSourceProvider),
    ref.watch(geocodingCachingDataSourceProvider),
  ),
);
