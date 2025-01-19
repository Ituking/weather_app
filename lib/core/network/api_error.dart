import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

/// [ApiErrorType] 列挙型は、APIエラーの種類を定義します。
enum ApiErrorType {
  /// タイムアウトエラー
  timeout,

  /// リクエストのキャンセル
  cancel,

  /// 不正なリクエスト
  badRequest,

  /// 認証エラー
  unauthorized,

  /// リソースが見つからない
  notFound,

  /// リクエストが多すぎる
  tooManyRequests,

  /// サーバー内部エラー
  internalServerError,

  /// 不明なエラー
  unknown,
}

/// [ApiError] クラスは、APIエラーを表現します。
@freezed
class ApiError with _$ApiError {
  /// コンストラクタ。
  ///
  /// [type] : エラーの種類を表す [ApiErrorType]。
  /// [message] : エラーメッセージ。
  const factory ApiError({
    required ApiErrorType type,
    required String message,
  }) = _ApiError;
}
