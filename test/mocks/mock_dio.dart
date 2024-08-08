import 'package:dio/dio.dart';
import 'package:mockito/mockito.dart';

// MockDioクラスの定義
// Dioクラスをモック化して、テスト時に実際のHTTPリクエストを行わないようにします。
class MockDio extends Mock implements Dio {
  // getメソッドのオーバーライド
  // Dioクラスのgetメソッドをオーバーライドして、モックの振る舞いを定義します。
  @override
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters, // クエリパラメータ（GETリクエストのURLに追加される）
    Options? options, // リクエストオプション（ヘッダー、タイムアウト設定など）
    CancelToken? cancelToken, // リクエストキャンセル用のトークン
    ProgressCallback? onReceiveProgress,
    Object? data,
  }) {
    // レスポンスデータの受信進行状況を通知するコールバック
    return super.noSuchMethod(
      Invocation.method(#get, [
        path
      ], {
        #queryParameters: queryParameters,
        #options: options,
        #cancelToken: cancelToken,
        #onReceiveProgress: onReceiveProgress,
        #data: data,
      }),
      // モックの戻り値を定義
      // Future.valueを使用して、Future<Response<T>>型のレスポンスを即座に返します。
      returnValue:
          Future.value(Response<T>(requestOptions: RequestOptions(path: path))),
      // メソッドがモックされていない場合の戻り値を定義
      returnValueForMissingStub:
          Future.value(Response<T>(requestOptions: RequestOptions(path: path))),
    );
  }
}
