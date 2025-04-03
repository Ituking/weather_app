import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class AppLog {
  static final Logger _logger = Logger();

  static void debug({required String message, StackTrace? stackTrace}) {
    _log(message: message, level: Level.debug, stackTrace: stackTrace);
  }

  static void info({required String message, StackTrace? stackTrace}) {
    _log(message: message, level: Level.info, stackTrace: stackTrace);
  }

  static void error({
    required String message,
    required Object exception,
    StackTrace? stackTrace,
  }) {
    _log(
      message: message,
      level: Level.error,
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  static void _log({
    required String message,
    required Level level,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    if (!kReleaseMode) {
      _logger.log(
        level,
        message,
        error: exception,
        stackTrace: stackTrace,
      );
    }

    if (level.index >= Level.info.index) {
      FirebaseCrashlytics.instance.log(message);
    }

    if (level.index >= Level.error.index && exception != null) {
      FirebaseCrashlytics.instance.recordFlutterError(
        FlutterErrorDetails(
          exception: exception,
          stack: stackTrace,
        ),
      );
    }
  }
}
