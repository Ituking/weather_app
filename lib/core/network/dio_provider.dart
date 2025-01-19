import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/providers/dio_error_handler_provider.dart';

/// 天気予報APIとの通信に使用される[Dio]クライアントを提供するプロバイダー。
final dioProvider = Provider<Dio>((ref) {
  // Dioの基本設定を定義
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 5), // 接続タイムアウトを5秒に設定
    receiveTimeout: const Duration(seconds: 3), // 応答受信タイムアウトを3秒に設定
    headers: {'Content-Type': 'application/json'}, // デフォルトのリクエストヘッダーをJSONに設定
  ));

  // DioErrorHandlerを読み込み、エラーハンドリングに使用
  final dioErrorHandler = ref.read(dioErrorHandlerProvider);

  // デバッグモードの場合のみログインターセプターを追加
  if (kDebugMode) {
    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  // エラーハンドリング用インターセプターの設定
  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (DioException e, ErrorInterceptorHandler handler) {
        // エラーハンドラーでDioExceptionを処理し、適切なApiErrorに変換
        final apiError = dioErrorHandler.handle(e);

        // 元のDioExceptionに変換後のApiErrorを適用
        final newException = DioException(
          type: e.type, // 元のエラータイプを維持
          requestOptions: e.requestOptions,
          response: e.response,
          error: apiError, // ApiErrorに置き換え
        );

        // 新しいDioExceptionを次のハンドラーに渡す
        handler.next(newException);
      },
    ),
  );

  return dio;
});
