import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/weather/forecast.dart';
import '../async_weather_view_model.dart';

final asyncWeatherViewModelProvider =
    AsyncNotifierProvider<AsyncWeatherViewModel, Forecast>(
  AsyncWeatherViewModel.new,
);
