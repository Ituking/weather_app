import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/logger/app_log.dart';
import '../models/forecast.dart';
import '../repositories/unified_weather_repository_provider.dart';

class AsyncWeatherViewModel extends AsyncNotifier<Forecast> {
  @override
  Future<Forecast> build() {
    throw UnimplementedError();
  }

  Future<void> fetchWeather(String cityName) async {
    state = const AsyncLoading();

    final repo = ref.read(unifiedWeatherRepositoryProvider);
    final result = await repo.getWeather(cityName);

    result.when(
      success: (forecast) => state = AsyncData(forecast),
      failure: (e) {
        AppLog.error(
          message: '天気取得失敗（$cityName）: ${e.message}',
          exception: e,
          stackTrace: StackTrace.current,
        );
        state = AsyncError(e, StackTrace.current);
      },
    );
  }
}
