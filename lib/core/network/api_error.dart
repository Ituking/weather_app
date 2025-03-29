import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

/// [ApiErrorType] 列挙型は、APIエラーの種類を定義します。
enum ApiErrorType {
  timeout,
  cancel,
  badRequest,
  unauthorized,
  notFound,
  tooManyRequests,
  internalServerError,
  unknown,
}

/// [ApiError] クラスは、APIエラーを表現します。
@freezed
class ApiError with _$ApiError {
  const factory ApiError({
    required ApiErrorType type,
    required String message,
  }) = _ApiError;
}
