import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../view/screens/city_search_screen.dart';
import '../../view/screens/error_display_screen.dart';
import '../../view/screens/weather_result_screen.dart';
import '../../view_model/error_view_model.dart';
import '../../view_model/providers/error_view_model_provider.dart';

/// アプリケーションのルーターを定義するクラス。
class AppRouter {
  /// アプリケーションのルーター設定。
  static final router = GoRouter(
    routes: [
      /// ルート設定: ルートパス '/' に対応する画面を[CitySearchScreen]に設定。
      GoRoute(
        path: '/',
        builder: (context, state) => const CitySearchScreen(),
      ),

      /// ルート設定: ルートパス '/result' に対応する画面を[WeatherResultScreen]に設定。
      GoRoute(
        path: '/result',
        builder: (context, state) => const WeatherResultScreen(),
      ),

      /// ルート設定: エラー画面に遷移するルートを定義。
      GoRoute(
        path: '/error',
        builder: (context, state) {
          // エラーメッセージをクエリパラメータから取得して渡す
          final errorMessage = state.extra.toString();

          return ProviderScope(
            overrides: [
              errorViewModelProvider.overrideWith(() {
                final viewModel = ErrorViewModel();
                viewModel.setErrorMessage(errorMessage);
                return viewModel;
              }),
            ],
            child: const ErrorDisplayScreen(),
          );
        },
      ),
    ],
  );
}
