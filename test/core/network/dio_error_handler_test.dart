import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/core/network/dio_error_handler.dart';
import 'package:weather_app/core/strings/dio_error_handler_strings.dart';

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
      expect(apiError.message, DioErrorHandlerStrings.connectionTimeout);
    });

    test('送信タイムアウトエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.sendTimeout,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.timeout);
      expect(apiError.message, DioErrorHandlerStrings.sendTimeout);
    });

    test('受信タイムアウトエラーを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.receiveTimeout,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.timeout);
      expect(apiError.message, DioErrorHandlerStrings.receiveTimeout);
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
      expect(apiError.message, DioErrorHandlerStrings.badRequest);
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
      expect(apiError.message, DioErrorHandlerStrings.unauthorized);
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
      expect(apiError.message, DioErrorHandlerStrings.notFound);
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
      expect(apiError.message, DioErrorHandlerStrings.tooManyRequests);
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
      expect(apiError.message, DioErrorHandlerStrings.internalServerError);
    });

    test('不明なエラータイプを処理する', () {
      final dioError = DioException(
        type: DioExceptionType.unknown,
        requestOptions: RequestOptions(path: ''),
      );

      final apiError = dioErrorHandler.handle(dioError);

      expect(apiError.type, ApiErrorType.unknown);
      expect(apiError.message, DioErrorHandlerStrings.unknownError);
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
      expect(apiError.message, DioErrorHandlerStrings.unknownError);
    });
  });
}
