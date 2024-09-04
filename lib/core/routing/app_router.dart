import 'package:go_router/go_router.dart';
import 'package:weather_app/view/screens/city_search_screen.dart';
import 'package:weather_app/view/screens/weather_result_screen.dart';

class AppRouter {
  // アプリケーションのルーターを定義
  static final router = GoRouter(routes: [
    // ルート設定: ルートパス '/' に対応する画面を CitySearchScreen に設定
    GoRoute(
      path: '/',
      builder: (context, state) => const CitySearchScreen(),
    ),
    // ルート設定: ルートパス '/result' に対応する画面を WeatherResultScreen に設定
    GoRoute(
      path: '/result',
      builder: (context, state) => const WeatherResultScreen(),
    ),
  ]);
}
