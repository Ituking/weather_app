import 'package:go_router/go_router.dart';
import 'package:weather_app/view/screens/city_search_screen.dart';
import 'package:weather_app/view/screens/weather_result_screen.dart';

class AppRouter {
  // アプリケーションのルーターを定義
  static final router = GoRouter(routes: [
    // ルート設定: ルートパス '/' に対応する画面を CitySearchScreen に設定
    GoRoute(
      path: '/',
      builder: (context, state) => CitySearchScreen(),
    ),
    // ルート設定: ルートパス '/result/:city' に対応する画面を WeatherResultScreen に設定
    GoRoute(
      path: '/result/:city',
      builder: (context, state) {
        // パスパラメータから都市名を取得する
        final cityName = state.pathParameters['city'];
        // 取得した都市名を WeatherResultScreen に渡して画面を表示
        return WeatherResultScreen(
          cityName: cityName!,
        );
      },
    ),
  ]);
}
