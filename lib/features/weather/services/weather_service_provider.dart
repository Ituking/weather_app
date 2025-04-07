import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repositories/firestore_weather_repository_provider.dart';
import '../repositories/weather_repository_provider.dart';
import 'weather_service.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService(
    apiRepository: ref.read(weatherRepositoryProvider),
    firestoreRepository: ref.read(firestoreWeatherRepositoryProvider),
  );
});
