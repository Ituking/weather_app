import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error_state.dart';
import '../error_view_model.dart';

// プロバイダー定義
final errorViewModelProvider = NotifierProvider<ErrorViewModel, ErrorState>(
  ErrorViewModel.new,
);
