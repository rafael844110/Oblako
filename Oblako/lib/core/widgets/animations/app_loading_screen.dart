import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AppLoadingScreen extends StatelessWidget {
  const AppLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.fourRotatingDots(
          color: AppColors.primary,
          size: 100,
        ),
      ),
    );
  }
}
