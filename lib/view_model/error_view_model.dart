import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/view_model/error_state.dart';

// ErrorViewModelクラスは、エラー状態を管理するための状態管理クラスです。
class ErrorViewModel extends Notifier<ErrorState> {
  @override
  ErrorState build() {
    return ErrorState();
  }

  // エラーメッセージのみを設定するメソッド（非同期に処理）
  void setErrorMessage(String message) {
    Future.microtask(() {
      final error = ApiError(
        type: ApiErrorType.unknown,
        message: message,
      );
      state = state.copyWith(error: error);
    });
  }

  // エラー状態を設定するメソッド。
  void setError(ApiError error) {
    state = state.copyWith(error: error);
  }

  // エラー状態をクリアするメソッド。
  void clearError() {
    state = state.copyWith(error: null);
  }
}
