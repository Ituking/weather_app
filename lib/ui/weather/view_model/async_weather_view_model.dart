import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/logger/app_log.dart';
import '../../../data/repositories/weather/unified_weather_repository_provider.dart';
import '../../../domain/models/weather/forecast.dart';

class AsyncWeatherViewModel extends AsyncNotifier<List<Forecast>> {
  @override
  Future<List<Forecast>> build() async {
    return [];
  }

  Future<void> fetchWeather(String cityName) async {
    state = const AsyncLoading();

    final repo = ref.read(unifiedWeatherRepositoryProvider);
    final result = await repo.getWeather(cityName);

    result.when(
      success: (forecasts) {
        if (forecasts.isNotEmpty) {
          state = AsyncData(forecasts);
        } else {
          state = AsyncError(
            Exception('天気データが空です'),
            StackTrace.current,
          );
        }
      },
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
