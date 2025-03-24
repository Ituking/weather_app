import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/logger/logger_provider.dart';
import '../models/forecast.dart';
import 'forecasts_ref.dart';

class ForecastRepository {
  ForecastRepository(this._ref);

  final Ref _ref;

  /// 特定のドキュメントIDから `Forecast` データを取得
  Future<Forecast?> getForecastById({
    required String forecastId,
  }) async {
    final logger = _ref.read(loggerProvider);

    try {
      final docSnapshot = await forecastsRef().doc(forecastId).get();
      if (docSnapshot.exists) {
        return docSnapshot.data();
      } else {
        return null;
      }
    } on Exception catch (e, stackTrace) {
      logger.logError(
        'Error fetching forecast: $e',
        stackTrace,
      );
      return null;
    }
  }

  /// 指定した日付リストに対応する `Forecast` データを一括取得
  Future<List<Forecast>> getForecastsByDates({
    required List<String> forecastDates,
  }) async {
    final logger = _ref.read(loggerProvider);

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
    } on Exception catch (e, stackTrace) {
      logger.logError(
        'Error fetching forecasts: $e',
        stackTrace,
      );
      return [];
    }
  }
}
