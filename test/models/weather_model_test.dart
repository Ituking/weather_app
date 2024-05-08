import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/models/weather_model.dart';

void main() {
  // WeatherModelのテストグループを定義
  group('WeatherModel Test', () {
    // JSONからオブジェクトを生成するテスト
    test('fromJson creates correct instance', () {
      // テスト用のダミーJSONデータ
      var json = {
        'temperature': 20.0,
        'description': 'Clear sky',
        'windSpeed': 5.0,
        'humidity': 70,
        'cityName': 'Tokyo'
      };

      // JSONからWeatherModelを生成
      var weather = WeatherModel.fromJson(json);
      // 各フィールドが正しく設定されているか確認
      expect(weather.temperature, 20.0);
      expect(weather.description, 'Clear sky');
      expect(weather.windSpeed, 5.0);
      expect(weather.humidity, 70);
      expect(weather.cityName, 'Tokyo');
    });

    // オブジェクトからJSONへの変換をテスト
    test('toJson returns correct JSON map', () {
      // WeatherModelのインスタンスを作成
      var weather = const WeatherModel(
          temperature: 20.0,
          description: 'Clear sky',
          windSpeed: 5.0,
          humidity: 70,
          cityName: 'Tokyo');

      // WeatherModelをJSONに変換
      var json = weather.toJson();
      // JSONが正しく生成されているか確認
      expect(json['temperature'], 20.0);
      expect(json['description'], 'Clear sky');
      expect(json['windSpeed'], 5.0);
      expect(json['humidity'], 70);
      expect(json['cityName'], 'Tokyo');
    });
  });
}
