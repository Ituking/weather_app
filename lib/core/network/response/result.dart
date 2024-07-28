import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
// Result<T>クラスは、ジェネリックな結果を表現するためのデータクラスです。
// 成功した場合はSuccessを、失敗した場合はFailureを使用します。
abstract class Result<T> with _$Result<T> {
  // 成功時のファクトリコンストラクタ。
  // [value]は成功した場合に返される値です。
  const factory Result.success(T value) = Success<T>;
  // 失敗時のファクトリコンストラクタ。
  // [error]は失敗した場合に発生したDioExceptionです。
  const factory Result.failure(DioException error) = Failure<T>;
}
