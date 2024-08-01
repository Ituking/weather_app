import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/view/screens/city_search_screen.dart';

void main() {
  testWidgets('CitySearchScreen displays correctly',
      (WidgetTester tester) async {
    // テストウィジェットをProviderScopeでラップ
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that CitySearchScreen is displayed
    expect(find.byType(CitySearchScreen), findsOneWidget);
  });
}
