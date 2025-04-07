import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/response/result.dart';
import '../../models/forecast.dart';
import '../city_weather_notifier.dart';

/// [CityWeatherNotifier]を提供する[NotifierProvider]
final cityWeatherNotifierProvider =
    NotifierProvider<CityWeatherNotifier, AsyncValue<Result<Forecast>>>(
        CityWeatherNotifier.new);
