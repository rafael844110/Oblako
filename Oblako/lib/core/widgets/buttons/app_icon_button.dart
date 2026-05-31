import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // Handle button press
        context.router.pushNamed('/profile');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Icon button pressed!'),
          ),
        );
      },
      icon: const Icon(Icons.person),
    );
  }
}
