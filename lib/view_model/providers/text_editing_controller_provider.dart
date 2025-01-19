import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// [TextEditingController]を提供する[Provider]
final textEditingControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());
