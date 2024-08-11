import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/view_model/error_state.dart';

// ErrorViewModelクラスは、エラー状態を管理するための状態管理クラスです。
class ErrorViewModel extends Notifier<ErrorState> {
  @override
  // 初期状態を設定するメソッド。
  ErrorState build() {
    return ErrorState();
  }

  // エラー状態を設定するメソッド。
  // 引数としてApiErrorオブジェクトを受け取り、現在の状態を更新します。
  void setError(ApiError error) {
    state = state.copyWith(error: error);
  }

  // エラー状態をクリアするメソッド。
  // エラープロパティをnullに設定して状態を更新します。
  void clearError() {
    state = state.copyWith(error: null);
  }
}
