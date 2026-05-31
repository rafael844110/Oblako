import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: TextButton.icon(
        onPressed: () {
          context.read<AuthCubit>().signOut();
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: Text(
          'Log Out',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
