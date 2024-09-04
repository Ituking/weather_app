import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_app/core/routing/app_router.dart';

// AppRouterを提供するProvider
final appRouterProvider = Provider<GoRouter>((ref) => AppRouter.router);
