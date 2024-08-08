import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/dio_error_handler.dart';

// プロバイダー定義
final dioErrorHandlerProvider = Provider<DioErrorHandler>((ref) {
  return DioErrorHandler();
});
