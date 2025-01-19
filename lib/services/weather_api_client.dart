import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../core/network/response/weather_response.dart';

part 'weather_api_client.g.dart';

/// 天気情報を取得するためのAPIクライアント。
@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5/")
abstract class WeatherApiClient {
  /// [Dio]インスタンスとオプションの[baseUrl]を受け取るファクトリコンストラクタ。
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  /// 指定された都市の天気情報を取得します。
  ///
  /// - Parameters:
  /// [cityName] : 天気情報を取得する都市の名前。
  /// [apiKey] : OpenWeatherMap APIのキー。
  /// [lang] : レスポンスの言語設定。
  /// [units] : 単位系（例: メートル法や華氏）。
  /// - Returns: [WeatherResponse]を含む[Future]。
  @GET("forecast")
  Future<WeatherResponse> fetchWeather(
    @Query("q") String cityName,
    @Query("appId") String apiKey,
    @Query("lang") String lang,
    @Query("units") String units,
  );
}
