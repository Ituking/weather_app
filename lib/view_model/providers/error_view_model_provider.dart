import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/view_model/error_state.dart';
import 'package:weather_app/view_model/error_view_model.dart';

// プロバイダー定義
final errorViewModelProvider = NotifierProvider<ErrorViewModel, ErrorState>(
  ErrorViewModel.new,
);
