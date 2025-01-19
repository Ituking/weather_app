import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../weather_view_model.dart';

part 'weather_view_model_provider.g.dart';

/// [Riverpod] のプロバイダーを定義します。
///
/// このプロバイダーは、[WeatherViewModel] のインスタンスを提供します。
@riverpod
WeatherViewModel weatherViewModelProvider(Ref ref) {
  return WeatherViewModel();
}
