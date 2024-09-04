import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/view_model/city_weather_notifier.dart';

// CityWeatherNotifierを提供するProvider
final cityWeatherNotifierProvider =
    NotifierProvider<CityWeatherNotifier, AsyncValue<Result<WeatherResponse>>>(
        CityWeatherNotifier.new);
