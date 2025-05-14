import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../locale_notifier.dart';

final localeNotifierProvider = NotifierProvider<LocaleNotifier, Locale?>(
  LocaleNotifier.new,
);
