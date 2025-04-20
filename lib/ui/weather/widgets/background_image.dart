import 'package:flutter/material.dart';

/// [BackgroundImage]は画面全体に表示される背景画像ウィジェットです。
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withAlpha((0.5 * 255).toInt()),
          BlendMode.darken,
        ),
        child: Image.asset(
          'assets/images/background.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
