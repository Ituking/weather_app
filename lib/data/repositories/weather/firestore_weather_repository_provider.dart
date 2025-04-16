import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firestore_weather_repository.dart';
import 'firestore_weather_repository_impl.dart';

final firestoreWeatherRepositoryProvider = Provider<FirestoreWeatherRepository>(
  (ref) => FirestoreWeatherRepositoryImpl(),
);
