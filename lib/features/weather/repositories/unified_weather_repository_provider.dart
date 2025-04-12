import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firestore_weather_repository_provider.dart';
import 'unified_weather_repository.dart';
import 'weather_repository.dart';
import 'weather_repository_provider.dart';

/// 新しい統合リポジトリのプロバイダー
final unifiedWeatherRepositoryProvider = Provider<WeatherRepository>((ref) {
  final firestoreRepo = ref.watch(firestoreWeatherRepositoryProvider);
  final apiRepo = ref.watch(weatherRepositoryProvider);

  return UnifiedWeatherRepository(
    firestoreRepository: firestoreRepo,
    apiRepository: apiRepo,
  );
});
