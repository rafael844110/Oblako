import 'package:cullinarium/core/data/services/user_service.dart';
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTag extends StatelessWidget {
  const AppTag({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          UserService.getRoleIcon(label),
          const SizedBox(width: 6),
          Text(
            UserService.getRoleDisplayName(label),
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
