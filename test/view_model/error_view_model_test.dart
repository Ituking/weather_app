import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/extensions/api_error_type_messages.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/features/weather/view_model/providers/error_view_model_provider.dart';

void main() {
  group('ErrorViewModelのテスト', () {
    test('エラー状態のセットとクリアのテスト', () {
      final container = ProviderContainer();
      final errorViewModel = container.read(errorViewModelProvider.notifier);

      final apiError = ApiError(
        type: ApiErrorType.badRequest,
        message: ApiErrorType.badRequest.displayMessage,
      );

      // エラーを設定
      errorViewModel.setError(apiError);
      expect(container.read(errorViewModelProvider).error, apiError);

      // エラーをクリア
      errorViewModel.clearError();
      expect(container.read(errorViewModelProvider).error, null);
    });
  });
}
