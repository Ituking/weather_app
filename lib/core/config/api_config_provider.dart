import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/config/api_config.dart';
import 'package:weather_app/core/config/env.dart';

final apiConfigProvider = Provider<ApiConfig>((ref) {
  final apiKey = Env.openWeatherMapApiKey;
  return ApiConfig(apiKey: apiKey);
});
