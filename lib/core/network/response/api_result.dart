import 'package:freezed_annotation/freezed_annotation.dart';

import '../api_error.dart';

part 'api_result.freezed.dart';

/// [ApiResult] クラスは、操作の結果を表すジェネリックなデータクラスです。
///
/// 操作が成功した場合は [Success] を、失敗した場合は [Failure] を使用します。
@freezed
abstract class ApiResult<T> with _$ApiResult<T> {
  /// 操作が成功した場合に使用するコンストラクタです。
  ///
  /// [value] は成功時に返されるデータを表します。
  const factory ApiResult.success(T value) = Success<T>;

  /// 操作が失敗した場合に使用するコンストラクタです。
  ///
  /// [error] は失敗時に発生した [ApiError] を表します。
  const factory ApiResult.failure(ApiError error) = Failure<T>;
}
