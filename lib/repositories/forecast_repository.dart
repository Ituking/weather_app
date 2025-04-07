import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/logger/app_log.dart';
import '../features/weather/models/forecast.dart';
import 'forecasts_ref.dart';

class ForecastRepository {
  /// 特定のドキュメントIDから[Forecast]データを取得
  Future<Forecast?> getForecastById({
    required String forecastId,
  }) async {
    try {
      final docSnapshot = await forecastsRef().doc(forecastId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } catch (e, stackTrace) {
      AppLog.error(
        message: 'Error fetching forecast: $e',
        exception: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  /// 指定した日付リストに対応する[Forecast]データを一括取得
  Future<List<Forecast>> getForecastsByDates({
    required List<String> forecastDates,
  }) async {
    try {
      final querySnapshot = await forecastsRef()
          .where(FieldPath.documentId, whereIn: forecastDates)
          .get();

      return querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Forecast.fromJson({
          ...data.toJson(),
          'id': doc.id,
        });
      }).toList();
    } catch (e, stackTrace) {
      AppLog.error(
        message: 'Error fetching forecasts: $e',
        exception: e,
        stackTrace: stackTrace,
      );
      return [];
    }
  }
}
