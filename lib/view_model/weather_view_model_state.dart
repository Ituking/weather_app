import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/models/weather_model.dart';

part 'weather_view_model_state.freezed.dart';

@freezed
class WeatherViewModelState with _$WeatherViewModelState {
  factory WeatherViewModelState({
    WeatherModel? weather,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _WeatherViewModelState;
}
