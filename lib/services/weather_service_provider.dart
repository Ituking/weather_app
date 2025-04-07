import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/weather/repositories/firestore_weather_repository_provider.dart';
import '../features/weather/repositories/weather_repository_provider.dart';
import '../services/weather_service.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  return WeatherService(
    apiRepository: ref.read(weatherRepositoryProvider),
    firestoreRepository: ref.read(firestoreWeatherRepositoryProvider),
  );
});
