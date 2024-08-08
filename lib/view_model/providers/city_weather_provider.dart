import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';
import 'package:weather_app/view_model/providers/dio_error_handler_provider.dart';

// FutureProviderを定義して特定の都市の天気情報を取得する
final cityWeatherProvider =
    FutureProvider.family<Result<List<WeatherList>>, String>(
        (ref, cityName) async {
  // weatherRepositoryProviderからWeatherRepositoryのインスタンスを取得
  final weatherRepository = ref.read(weatherRepositoryProvider);

  try {
    // 指定された都市の天気情報を非同期に取得し、結果をresultに格納
    final result = weatherRepository.getWeather(cityName);
    // 取得した天気情報の結果を返す
    return result;
  } on DioException catch (e) {
    // DioExceptionをキャッチし、エラーハンドラーを使用して適切なApiErrorを生成
    final dioErrorHandler = ref.read(dioErrorHandlerProvider);
    final apiError = dioErrorHandler.handle(e);
    return Result.failure(apiError);
  } catch (e) {
    // その他のエラー処理
    return Result.failure(
        ApiError(type: ApiErrorType.unknown, message: e.toString()));
  }
});
