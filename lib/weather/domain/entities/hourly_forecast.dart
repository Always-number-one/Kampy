import '../../domain/entities/unit_system.dart';
import '../../domain/utils/unit_conversion.dart';
import 'package:equatable/equatable.dart';

class HourlyForecast extends Equatable {
  const HourlyForecast({
    required this.date,
    required this.temperature,
    required this.pop,
    required this.iconCode,
    required this.unitSystem,
  });

  final DateTime date;

  final double temperature;

  /// Probability of precipitation.
  final double pop;

  final String iconCode;

  final UnitSystem unitSystem;

  @override
  List<Object?> get props => [date, temperature, pop, iconCode, unitSystem];

  HourlyForecast changeUnitSystem(UnitSystem newUnitSystem) {
    if (unitSystem == newUnitSystem) {
      return this;
    }

    final double newTemperature;

    switch (unitSystem) {
      case UnitSystem.imperial:
        newTemperature = convertFahrenheitToCelsius(temperature);
        break;

      case UnitSystem.metric:
        newTemperature = convertCelsiusToFahrenheit(temperature);
    }

    return HourlyForecast(
      pop: pop,
      date: date,
      temperature: newTemperature,
      iconCode: iconCode,
      unitSystem: newUnitSystem,
    );
  }
}
