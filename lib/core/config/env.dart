import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'OPENWEATHERMAP_API_KEY_DEV', obfuscate: true)
  static String openWeatherMapApiKeyDev = _Env.openWeatherMapApiKeyDev;
}
