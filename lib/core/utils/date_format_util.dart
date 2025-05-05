import 'package:intl/intl.dart';

class DateFormatUtil {
  static String formatToDayLabel(int timestamp, {String locale = 'en_US'}) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formatter = DateFormat('EEE, d', locale);
    return formatter.format(date);
  }
}
