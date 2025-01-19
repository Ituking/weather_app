import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/api_error.dart';
import 'error_state.dart';

/// [ErrorViewModel]クラスは、アプリケーション内のエラー状態を管理します。
class ErrorViewModel extends Notifier<ErrorState> {
  @override
  ErrorState build() {
    return ErrorState();
  }

  /// エラーメッセージを設定します。
  /// [message] : 設定するエラーメッセージ。
  void setErrorMessage(String message) {
    Future.microtask(() {
      final error = ApiError(
        type: ApiErrorType.unknown,
        message: message,
      );
      state = state.copyWith(error: error);
    });
  }

  /// [ApiError]オブジェクトを設定します。
  /// [error] : 設定する[ApiError]オブジェクト。
  void setError(ApiError error) {
    state = state.copyWith(error: error);
  }

  /// エラー状態をクリアします。
  void clearError() {
    state = state.copyWith(error: null);
  }
}
