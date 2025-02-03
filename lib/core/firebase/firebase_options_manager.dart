import 'package:firebase_core/firebase_core.dart';

import 'firebase_options_dev.dart' as dev;
import 'firebase_options_stg.dart' as stg;
import 'firebase_options_prod.dart' as prod;

import '../config/flavor.dart';

/// Flavorに応じて適切なFirebaseOptionsを提供するクラス
class FirebaseOptionsManager {
  static FirebaseOptions get options {
    switch (flavor) {
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      case Flavor.stg:
        return stg.DefaultFirebaseOptions.currentPlatform;
      case Flavor.dev:
      default:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
