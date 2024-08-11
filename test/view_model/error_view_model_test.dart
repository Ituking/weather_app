import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/network/api_error.dart';
import 'package:weather_app/view_model/providers/error_view_model_provider.dart';

void main() {
  test('エラー状態のセットとクリアのテスト', () {
    final container = ProviderContainer();
    final errorViewModel = container.read(errorViewModelProvider.notifier);

    const apiError = ApiError(
      type: ApiErrorType.badRequest,
      message: 'Bad request',
    );

    // エラーを設定
    errorViewModel.setError(apiError);
    expect(container.read(errorViewModelProvider).error, apiError);

    // エラーをクリア
    errorViewModel.clearError();
    expect(container.read(errorViewModelProvider).error, null);
  });
}
