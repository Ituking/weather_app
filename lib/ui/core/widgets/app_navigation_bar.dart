import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// アプリケーション全体で使用するナビゲーションバー。
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
    required this.navigationShell,
  });

  /// GoRouterのStatefulShellRouteから渡されるナビゲーションシェル
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            // 現在選択中のタブを再タップしてもトップに戻さない
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
