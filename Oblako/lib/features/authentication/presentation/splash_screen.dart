import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset(
            'assets/layout/background.png',
            height: size.height,
            fit: BoxFit.fitHeight,
          ),
          Positioned(
            top: kToolbarHeight * 2,
            child: Image.asset(
              'assets/icons/app_logo.png',
              width: size.width * 0.7,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/splash_right.png',
                  height: size.height * 0.4,
                  fit: BoxFit.fitHeight,
                ),
                Image.asset(
                  'assets/images/splash_left.png',
                  height: size.height * 0.4,
                  fit: BoxFit.fitHeight,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: kToolbarHeight,
            child: AppButton(
              title: 'Get Started',
              onPressed: () {
                context.router.pushNamed('/main');
              },
            ),
          ),
        ],
      ),
    );
  }
}
