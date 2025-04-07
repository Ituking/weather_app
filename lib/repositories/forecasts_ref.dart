import 'package:cloud_firestore/cloud_firestore.dart';

import '../features/weather/models/forecast.dart';

/// [Forecast]用コレクションのためのレファレンス
CollectionReference<Forecast> forecastsRef() {
  return FirebaseFirestore.instance
      .collection('forecasts')
      .withConverter<Forecast>(
    fromFirestore: (snapshot, _) {
      final data = snapshot.data()!;
      return Forecast.fromJson(<String, dynamic>{
        ...data,
        'id': snapshot.id,
      });
    },
    toFirestore: (forecast, _) {
      final json = forecast.toJson()..remove('id');
      return json;
    },
  );
}
