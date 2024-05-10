import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/config/env.dart';

void main() {
  test('API Key should be loaded from environment variables', () {
    // env.dart に _Env.apiKey が定義されていると仮定
    expect(Env.apiKey, isNotNull); // APIキーがnullでないことを確認
  });
}
