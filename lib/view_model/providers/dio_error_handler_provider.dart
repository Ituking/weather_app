import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_error_handler.dart';

/// [DioErrorHandler]を提供する[Provider]
final dioErrorHandlerProvider = Provider<DioErrorHandler>((ref) {
  return DioErrorHandler();
});
