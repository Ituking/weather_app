import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

// APIエラーの種類を定義する列挙型
enum ApiErrorType {
  timeout, // タイムアウト
  cancel, // リクエストキャンセル
  badRequest, // 不正なリクエスト
  unauthorized, // 認証エラー
  notFound, // リソースが見つからない
  tooManyRequests, // リクエストが多すぎる
  internalServerError, // サーバー内部エラー
  unknown, // 不明なエラー
}

// APIエラーを表現するクラス
@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    required ApiErrorType type, // エラーの種類
    required String message, // エラーメッセージ
  }) = _ApiError;
}
