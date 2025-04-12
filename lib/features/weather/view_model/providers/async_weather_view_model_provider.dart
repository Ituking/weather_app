import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/weather/models/forecast.dart';
import 'package:weather_app/features/weather/view_model/async_weather_view_model.dart';

final asyncWeatherViewModelProvider =
    AsyncNotifierProvider<AsyncWeatherViewModel, Forecast>(
  AsyncWeatherViewModel.new,
);
