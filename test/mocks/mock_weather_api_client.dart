import 'package:mockito/annotations.dart';
import 'package:weather_app/services/weather_api_client.dart';

// WeatherApiClientクラスのモックを生成するためのアノテーション。
// `build_runner`コマンドを実行することで、指定されたクラスのモッククラスが自動的に生成されます。
@GenerateMocks([WeatherApiClient])
void main() {
  // このファイルはモックを生成するためだけに存在します。`main` 関数は何も実行しません。
}
