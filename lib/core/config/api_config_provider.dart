import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_config.dart';
import 'env.dart';

final apiConfigProvider = Provider<ApiConfig>((ref) {
  final apiKey = Env.openWeatherMapApiKey;
  return ApiConfig(apiKey: apiKey);
});
