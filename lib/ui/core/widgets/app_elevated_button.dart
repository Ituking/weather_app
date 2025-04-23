import 'package:flutter/material.dart';

import '../../../core/theme/app_elevated_button_theme.dart';

class AppElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Future<void> Function()? onPressedAsync;

  const AppElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.onPressedAsync,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppElevatedButtonTheme>()!;

    return ElevatedButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!();
        } else if (onPressedAsync != null) {
          onPressedAsync!();
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.backgroundColor,
        foregroundColor: theme.textColor,
        elevation: theme.elevation,
        minimumSize: theme.minimumSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(theme.borderRadius),
        ),
        textStyle: theme.textStyle,
      ),
      child: Text(text),
    );
  }
}
