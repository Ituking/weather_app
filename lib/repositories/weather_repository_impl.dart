import 'package:dio/dio.dart';
import 'package:weather_app/core/config/env.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/core/network/response/weather_list.dart';
import 'package:weather_app/core/network/response/weather_response.dart';
import 'package:weather_app/repositories/weather_repository.dart';
import 'package:weather_app/services/weather_api_client.dart';

// WeatherRepositoryImplクラスは、WeatherRepositoryインターフェースの具体的な実装を提供します。
// WeatherApiClientを使用して、指定された都市の天気データを取得します。
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherApiClient apiClient;

  // WeatherRepositoryImplのコンストラクタ。
  // [apiClient]を受け取り、フィールドに設定します。
  WeatherRepositoryImpl({required this.apiClient});

  // 指定された都市名 [cityName] の天気データを取得し、WeatherListに変換して返します。
  // データ取得または変換に失敗した場合は例外をスローします。
  //
  // [cityName] - 天気データを取得する都市の名前
  // 戻り値 - 取得した天気データを含むWeatherListのリスト
  // 例外 - データ取得または変換に失敗した場合に例外をスロー
  @override
  Future<Result<List<WeatherList>>> getWeather(String cityName) async {
    try {
      // WeatherApiClientを使用して指定された都市の天気データを取得
      final WeatherResponse weatherResponse = await apiClient.fetchWeather(
        cityName,
        Env.apiKey,
        'ja',
        'metric',
      );

      return Result.success(weatherResponse.list);
    } catch (e) {
      if (e is DioException) {
        return Result.failure(e);
      }
      return Result.failure(DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Unknown error',
      ));
    }
  }
}
