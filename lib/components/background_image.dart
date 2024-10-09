import 'package:flutter/material.dart';

// BackgroundImageは画面全体に表示される背景画像ウィジェット
class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.5),
          BlendMode.darken,
        ),
        child: Image.asset(
          'assets/images/clouds-4215608_1280.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
