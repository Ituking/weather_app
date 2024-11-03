import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/config/env.dart';

void main() {
  test('API Key should be loaded from environment variables', () {
    // env.dart に _Env.openWeatherMapApiKeyDev が定義されていると仮定
    expect(Env.openWeatherMapApiKeyDev, isNotNull); // APIキーがnullでないことを確認
  });
}
