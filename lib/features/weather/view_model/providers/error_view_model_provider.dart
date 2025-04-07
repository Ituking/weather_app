import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error_state.dart';
import '../error_view_model.dart';

/// [ErrorViewModel]を提供する[NotifierProvider]
final errorViewModelProvider = NotifierProvider<ErrorViewModel, ErrorState>(
  ErrorViewModel.new,
);
