import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/app_router.dart';

/// [AppRouter]を提供する[Provider]
final appRouterProvider = Provider<GoRouter>((ref) => AppRouter.router);
