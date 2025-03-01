import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/network/api_error.dart';

part 'error_state.freezed.dart';

/// [ErrorState]クラスは、アプリケーション内のエラー状態を管理します。
@freezed
class ErrorState with _$ErrorState {
  /// [error] : エラー情報を保持するオプショナルなプロパティ。
  factory ErrorState({
    ApiError? error,
  }) = _ErrorState;
}
