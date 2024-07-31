import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/repositories/weather_repository_provider.dart';

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
  } catch (e) {
    // エラーをキャッチし、Result.failureを返す
    return Result.failure(DioException(
      requestOptions: RequestOptions(path: ''),
      error: e,
    ));
  }
});
