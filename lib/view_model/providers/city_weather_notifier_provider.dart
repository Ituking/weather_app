import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/response/result.dart';
import '../../core/network/response/weather_response.dart';
import '../city_weather_notifier.dart';

/// [CityWeatherNotifier]を提供する[NotifierProvider]
final cityWeatherNotifierProvider =
    NotifierProvider<CityWeatherNotifier, AsyncValue<Result<WeatherResponse>>>(
        CityWeatherNotifier.new);
