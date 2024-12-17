import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_logger.dart';
import 'i_logger.dart';

final loggerProvider = Provider<ILogger>((ref) => AppLogger());
