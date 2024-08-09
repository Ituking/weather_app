import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/view_model/providers/dio_error_handler_provider.dart';

// ApiServiceクラスの定義
class ApiService {
  final Dio _dio;
  final ProviderRef ref;

  // コンストラクタでDioインスタンスとProviderRefを受け取る
  ApiService(this._dio, this.ref);

  // 一般的なGETリクエストを処理するメソッド
  Future<Result<T>> get<T>(String url) async {
    try {
      // Dioを使ってGETリクエストを実行し、レスポンスを取得
      final response = await _dio.get<T>(url);
      // 成功した場合、Result.successにレスポンスデータを渡す
      return Result.success(response.data as T);
    } on DioException catch (e) {
      // エラーが発生した場合、handleDioError関数でエラーを処理し、Result.failureを返す
      final dioErrorHandler = ref.read(dioErrorHandlerProvider);
      final apiError = dioErrorHandler.handle(e);
      return Result.failure(apiError);
    }
  }
}
