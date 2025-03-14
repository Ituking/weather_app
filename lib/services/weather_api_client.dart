import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';

import '../core/network/api_error.dart';
import '../core/network/response/result.dart';
import '../core/network/response/weather_response.dart';
import 'i_weather_api_client.dart';

/// [FirebaseFunctions]を利用するAPIクライアント
class WeatherApiClient implements IWeatherApiClient {
  final FirebaseFunctions _functions;

  WeatherApiClient(this._functions);

  /// 指定された都市の天気情報を[FirebaseFunctions]経由で取得
  @override
  Future<Result<WeatherResponse>> fetchWeather(String cityName) async {
    try {
      final callable = _functions.httpsCallable('getWeatherForCity');
      final response = await callable.call({'city': cityName});
      if (kDebugMode) {
        print("レスポンス全体: ${jsonEncode(response.data)}");
        print("都市名: ${response.data['city']}");
        print("気温: ${response.data['temperature']}℃");
        print("タイムスタンプ: ${response.data['timestamp']}");
      }

      return Result.success(WeatherResponse.fromJson(response.data));
    } on FirebaseFunctionsException catch (e) {
      return Result.failure(ApiError(
          type: ApiErrorType.internalServerError,
          message: e.message ?? 'Unknown Firebase error'));
    } catch (e) {
      return Result.failure(
          ApiError(type: ApiErrorType.unknown, message: e.toString()));
    }
  }
}
