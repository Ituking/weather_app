import 'dart:io';

import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

import 'async_file_output.dart';
import 'i_logger.dart';

/// アプリケーション全体で使用するロガー
class AppLogger implements ILogger {
  static final AppLogger _instance = AppLogger._internal();
  factory AppLogger() => _instance;

  late Logger _logger;
  late File _logFile;

  AppLogger._internal() {
    _initializeLogger();
  }

  /// ロガーの初期化処理
  Future<void> _initializeLogger() async {
    // アプリケーションディレクトリ内のログファイルを設定
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/app_logs.txt');

    // 環境フラグをチェック
    final isProduction = bool.fromEnvironment('dart.vm.product'); // 本番環境

    // Loggerの設定
    _logger = Logger(
      printer: PrettyPrinter(
        methodCount: isProduction ? 0 : 2, // 本番環境ではスタックトレースを抑制
        errorMethodCount: 3, // エラーのスタックトレースの深さ
        lineLength: 80, // 1行あたりの長さ
        colors: !isProduction, // 本番環境ではカラー出力を無効化
        printEmojis: !isProduction, // 本番環境では絵文字を無効化
        dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart, // 時刻表示
      ),
      output: MultiOutput(([
        ConsoleOutput(),
        if (isProduction) AsyncFileOutput(_logFile), // 本番環境ではファイル出力のみ
      ])),
    );
  }

  @override
  void log(String message, [Level level = Level.info]) {
    switch (level) {
      case Level.trace:
        _logger.t("Trace: $message");
        break;
      case Level.debug:
        _logger.d("Debug: $message");
        break;
      case Level.info:
        _logger.i("Info: $message");
        break;
      case Level.warning:
        _logger.w("Warning: $message");
        break;
      case Level.error:
        _logger.e("Error: $message");
        break;
      case Level.fatal:
        _logger.f("Fatal: $message");
        break;
      default: // デフォルトケースを追加
        _logger.i("Unhandled log level: $level, Message: $message");
    }
  }

  @override
  void logError(dynamic error, StackTrace stackTrace) {
    _logger.e('Error: $error', error: error, stackTrace: stackTrace);
  }

  /// ログファイルを取得
  File get logFile => _logFile;

  /// ログ内容を取得（テスト用）
  List<String> getLogs() {
    if (_logFile.existsSync()) {
      return _logFile.readAsLinesSync();
    }
    return [];
  }
}
