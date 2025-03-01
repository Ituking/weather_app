import 'package:firebase_core/firebase_core.dart';

import '../config/flavor.dart';
import 'firebase_options_dev.dart' as dev;
import 'firebase_options_prod.dart' as prod;
import 'firebase_options_stg.dart' as stg;

/// [Flavor]に応じて適切な[FirebaseOptions]を提供するクラス
class FirebaseOptionsManager {
  static FirebaseOptions get options {
    switch (flavor) {
      case Flavor.prod:
        return prod.DefaultFirebaseOptions.currentPlatform;
      case Flavor.stg:
        return stg.DefaultFirebaseOptions.currentPlatform;
      case Flavor.dev:
        return dev.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
