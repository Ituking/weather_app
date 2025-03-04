import 'package:firebase_core_platform_interface/test.dart';
import 'package:flutter_test/flutter_test.dart';

void setupFirebaseMocks() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setupFirebaseCoreMocks();
}
