import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/ui/weather/screens/city_search_screen.dart';

import 'test_helpers/mocks/mock_firebase.dart';

void main() {
  setUpAll(() async {
    setupFirebaseMocks();
    await Firebase.initializeApp();
  });
  testWidgets('CitySearchScreen displays correctly',
      (WidgetTester tester) async {
    // テストウィジェットをProviderScopeでラップ
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Verify that CitySearchScreen is displayed
    expect(find.byType(CitySearchScreen), findsOneWidget);
  });
}
