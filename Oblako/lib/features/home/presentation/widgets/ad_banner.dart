import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          margin: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: theme.primaryColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Top Chefs',
                style: theme.textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Our chefs will cook\nthe most delicious\nhomemade food for you!',
                style: theme.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              AppButton(
                width: 120,
                margin: EdgeInsets.zero,
                color: Colors.white,
                textStyle: theme.textTheme.labelMedium!.copyWith(
                  color: theme.primaryColor,
                ),
                title: '30% off',
                onPressed: () {},
              ),
            ],
          ),
        ),
        Positioned(
          right: 20,
          bottom: 0,
          child: Image.asset(
            'assets/temp/chef.png',
            width: 150,
          ),
        ),
      ],
    );
  }
}
