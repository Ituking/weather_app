import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
abstract class Env {
  @EnviedField(varName: 'OPENWEATHERMAP_API_KEY_DEV', obfuscate: true)
  static String openWeatherMapApiKeyDev = _Env.openWeatherMapApiKeyDev;

  @EnviedField(varName: 'OPENWEATHERMAP_API_KEY_STG', obfuscate: true)
  static String openWeatherMapApiKeyStg = _Env.openWeatherMapApiKeyStg;

  @EnviedField(varName: 'OPENWEATHERMAP_API_KEY_PROD', obfuscate: true)
  static String openWeatherMapApiKeyProd = _Env.openWeatherMapApiKeyProd;

  static String get openWeatherMapApiKey {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'prod');
    switch (flavor) {
      case 'dev':
        return openWeatherMapApiKeyDev;
      case 'stg':
        return openWeatherMapApiKeyStg;
      case 'prod':
      default:
        return openWeatherMapApiKeyProd;
    }
  }
}
