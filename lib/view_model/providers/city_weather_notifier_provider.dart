import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/response/result.dart';
import '../../core/network/response/weather_response.dart';
import '../city_weather_notifier.dart';

// CityWeatherNotifierを提供するProvider
final cityWeatherNotifierProvider =
    NotifierProvider<CityWeatherNotifier, AsyncValue<Result<WeatherResponse>>>(
        CityWeatherNotifier.new);
