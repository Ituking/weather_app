import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/core/network/api_error.dart';

part 'error_state.freezed.dart';

// ErrorStateは、アプリケーションのエラーに関連する状態を保持するデータモデルです。
@freezed
class ErrorState with _$ErrorState {
  // ファクトリコンストラクタ。デフォルト値や省略可能なプロパティを定義します。
  factory ErrorState({
    ApiError? error, // エラーデータを保持するオプショナルなプロパティ
  }) = _ErrorState;
}
