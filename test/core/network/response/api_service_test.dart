import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/dio_error_handler.dart';
import 'package:weather_app/core/network/response/api_service.dart';
import 'package:weather_app/core/network/response/result.dart';
import 'package:weather_app/view_model/providers/dio_error_handler_provider.dart';

import '../../../mocks/mock_dio.dart';
import '../../../mocks/mock_provider_ref.mocks.dart';

void main() {
  // DioErrorHandlerのダミー値
  provideDummy<DioErrorHandler>(DioErrorHandler());
  group('ApiServiceのテスト', () {
    late MockDio mockDio; // Dioのモック
    late MockProviderRef mockRef; // ProviderRefのモック
    late DioErrorHandler dioErrorHandler; // DioErrorHandlerのインスタンス
    late ApiService apiService; // テスト対象のApiService

    setUp(() {
      // モックおよび依存関係の初期化
      mockDio = MockDio();
      mockRef = MockProviderRef();
      dioErrorHandler = DioErrorHandler();

      // ProviderRefのモックにDioErrorHandlerを設定
      when(mockRef.read(dioErrorHandlerProvider)).thenReturn(dioErrorHandler);

      // ApiServiceのインスタンスを作成
      apiService = ApiService(mockDio, mockRef);
    });

    test('GETリクエスト成功', () async {
      // テスト用のURLとデータを定義
      const testUrl = 'https://api.example.com/data';
      final testData = {'key': 'value'};

      // モックのレスポンスを設定
      when(mockDio.get<Map<String, dynamic>>(testUrl)).thenAnswer(
        (_) async => Response<Map<String, dynamic>>(
          data: testData,
          statusCode: 200,
          requestOptions: RequestOptions(path: testUrl),
        ),
      );

      // API呼び出しを実行
      final result = await apiService.get<Map<String, dynamic>>(testUrl);

      // 成功結果の検証
      expect(result, isA<Success<Map<String, dynamic>>>());
      expect((result as Success<Map<String, dynamic>>).value, testData);
    });

    test('GETリクエスト失敗', () async {
      // テスト用のURLを定義
      const testUrl = 'https://api.example.com/data';

      // 404エラーを模擬するDioExceptionを作成
      final dioException = DioException(
        requestOptions: RequestOptions(path: testUrl),
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: testUrl),
        ),
        type: DioExceptionType.badResponse,
      );

      // モックのエラーを設定
      when(mockDio.get<Map<String, dynamic>>(testUrl)).thenThrow(dioException);

      // API呼び出しを実行
      final result = await apiService.get<Map<String, dynamic>>(testUrl);

      // 失敗結果の検証
      expect(result, isA<Failure>());
      expect((result as Failure).error.type, ApiErrorType.notFound);
    });
  });
}
