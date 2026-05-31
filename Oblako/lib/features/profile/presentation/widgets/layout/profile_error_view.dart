import 'package:flutter/material.dart';

class ProfileErrorView extends StatelessWidget {
  const ProfileErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red[300],
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load profile',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Please try again',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              // Add your refresh logic here
              // context.read<ProfileCubit>().loadProfile();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
