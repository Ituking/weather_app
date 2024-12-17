import 'dart:io';

import 'package:logger/logger.dart';

/// 非同期ファイル出力クラス
class AsyncFileOutput extends LogOutput {
  final File _file;
  final Logger _errorLogger = Logger();

  AsyncFileOutput(this._file);

  @override
  void output(OutputEvent event) async {
    try {
      // 各行を結合して1つのログ文字列を作成
      final logMessages = event.lines.join('\n');

      // 非同期でファイルに書き込み（追記モード）
      await _file.writeAsString(
        '$logMessages\n',
        mode: FileMode.append,
        flush: true,
      );
    } catch (e) {
      _errorLogger.e('Failed to write log to file: $e');
    }
  }
}
