import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/dio_error_handler.dart';

void main() {
  group('DioErrorHandlerのテスト', () {
    final dioErrorHandler = DioErrorHandler();

    test('接続タイムアウトエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.connectionTimeout,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.timeout);
      expect(apiError.message, '接続タイムアウトが発生しました。\nネットワークの状態を確認してください。');
    });

    test('送信タイムアウトエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.sendTimeout,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.timeout);
      expect(apiError.message, 'リクエスト送信タイムアウトが発生しました。\nネットワークの状態を確認してください。');
    });

    test('受信タイムアウトエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.receiveTimeout,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.timeout);
      expect(apiError.message, 'レスポンス受信タイムアウトが発生しました。\nネットワークの状態を確認してください。');
    });

    test('不正リクエストエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 400,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.badRequest);
      expect(apiError.message, 'リクエストが不正です。\n必須パラメータが欠如しているか、フォーマットが不正です。');
    });

    test('認証エラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.unauthorized);
      expect(apiError.message, '認証されていません。\nAPIトークンが提供されていないか、アクセス権がありません。');
    });

    test('リソースが見つからないエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.notFound);
      expect(apiError.message, 'データが見つかりませんでした。\nリクエストパラメータに誤りがあります。');
    });

    test('リクエストが多すぎるエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 429,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.tooManyRequests);
      expect(apiError.message, 'リクエストが多すぎます。\nしばらく待ってから再試行してください。');
    });

    test('内部サーバーエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.internalServerError);
      expect(apiError.message, '内部サーバーエラーが発生しました。\nしばらくしてから再試行してください。');
    });

    test('不明なエラータイプを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.unknown,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.unknown);
      expect(apiError.message, '不明なエラーが発生しました。\n後でもう一度お試しください。');
    });

    test('不明なステータスコードを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.badResponse,
        response: Response(
          statusCode: 999,
          requestOptions: RequestOptions(path: ''),
        ),
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.unknown);
      expect(apiError.message, '不明なエラーが発生しました。\n後でもう一度お試しください。');
    });
  });
}
