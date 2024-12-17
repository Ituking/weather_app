import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../core/network/response/weather_response.dart';

part 'weather_api_client.g.dart';

// `WeatherApiClient` クラスは、天気情報を取得するためのAPIクライアントを定義します。
// このクラスは、`retrofit` パッケージを使用してHTTPリクエストを作成します。
@RestApi(baseUrl: "https://api.openweathermap.org/data/2.5/")
abstract class WeatherApiClient {
  // `WeatherApiClient` のファクトリコンストラクタ。
  // [dio] インスタンスとオプションの [baseUrl] を受け取ります。
  factory WeatherApiClient(Dio dio, {String baseUrl}) = _WeatherApiClient;

  // 指定された都市の天気情報を取得する非同期メソッド。
  //
  // [cityName] - 天気情報を取得する都市の名前。
  // [apiKey] - OpenWeatherMap APIのキー。
  // [lang] - レスポンスの言語。
  // [units] - 単位系（メトリック単位や帝国単位など）。
  //
  // 戻り値は `Future<WeatherResponse>` 型で、非同期に `WeatherResponse` を返します。
  @GET("forecast")
  Future<WeatherResponse> fetchWeather(
    @Query("q") String cityName, // クエリパラメータとして都市名を指定。
    @Query("appId") String apiKey, // クエリパラメータとしてAPIキーを指定。
    @Query("lang") String lang, // クエリパラメータとして言語を指定。
    @Query("units") String units, // クエリパラメータとして単位系を指定。
  );
}
