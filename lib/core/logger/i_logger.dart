import 'package:logger/logger.dart';

abstract class ILogger {
  void log(String message, [Level level = Level.info]);
  void logError(dynamic error, StackTrace stackTrace);
}
