import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../view_model/providers/dio_error_handler_provider.dart';
import 'result.dart';

/// [ApiService]クラスは、HTTPリクエストを処理するサービスです。
///
/// このクラスは、[Dio]を使用してHTTPリクエストを行い、
/// エラーハンドリングを提供します。
class ApiService {
  final Dio _dio;
  final Ref ref;

  /// コンストラクタは、[Dio]インスタンスと[Ref]を受け取ります。
  ApiService(this._dio, this.ref);

  /// 一般的なGETリクエストを処理するメソッドです。
  ///
  /// 指定された[url]に対してGETリクエストを行い、結果を[Result]として返します。
  ///
  /// [T] : 期待するレスポンスの型
  /// [url] : リクエスト先のURL
  ///
  /// 成功時は[Result.success]にレスポンスデータを渡し、
  /// エラー時は[Result.failure]にエラー情報を渡します。
  Future<Result<T>> get<T>(String url) async {
    try {
      final response = await _dio.get<T>(url);
      return Result.success(response.data as T);
    } on DioException catch (e) {
      final dioErrorHandler = ref.read(dioErrorHandlerProvider);
      final apiError = dioErrorHandler.handle(e);
      return Result.failure(apiError);
    }
  }
}
