import '../../core/either.dart';
import '../../core/failure.dart';
import '../../domain/entities/city.dart';
import '../../domain/entities/full_weather.dart';
import 'package:riverpod/riverpod.dart';

abstract class FullWeatherRepo {
  Future<Either<Failure, FullWeather>> getFullWeather(City city);
}

final fullWeatherRepoProvider =
    Provider<FullWeatherRepo>((ref) => throw UnimplementedError());
