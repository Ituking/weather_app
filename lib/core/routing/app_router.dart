import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../ui/core/widgets/app_navigation_bar.dart';
import '../../ui/settings/screens/language_selector_screen.dart';
import '../../ui/weather/screens/city_search_screen.dart';
import '../../ui/weather/screens/error_display_screen.dart';
import '../../ui/weather/screens/weather_result_screen.dart';
import '../../ui/weather/view_model/error_view_model.dart';
import '../../ui/weather/view_model/providers/error_view_model_provider.dart';

// 各ブランチ用のNavigatorKey
final searchNavigatorKey = GlobalKey<NavigatorState>();
final settingsNavigatorKey = GlobalKey<NavigatorState>();

/// アプリケーションのルーターを定義するクラス。
class AppRouter {
  static final router = GoRouter(
    initialLocation: '/search',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppNavigationBar(navigationShell: navigationShell);
        },
        branches: [
          // タブ 1: 検索機能
          StatefulShellBranch(
            navigatorKey: searchNavigatorKey,
            routes: [
              GoRoute(
                path: '/search',
                builder: (context, state) => const CitySearchScreen(),
              ),
              GoRoute(
                path: '/result',
                builder: (context, state) => const WeatherResultScreen(),
              ),
              GoRoute(
                path: '/error',
                builder: (context, state) {
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
          ),
          // タブ 2: 設定機能
          StatefulShellBranch(
            navigatorKey: settingsNavigatorKey,
            routes: [
              GoRoute(
                path: '/settings/language',
                builder: (context, state) => const LanguageSelectorScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
