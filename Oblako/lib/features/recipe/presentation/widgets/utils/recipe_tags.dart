import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RecipeTags extends StatelessWidget {
  const RecipeTags({super.key, required this.tags});

  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visibleTags = tags.take(2).toList();
    final extraCount = tags.length - visibleTags.length;

    return Wrap(
      spacing: 4,
      children: [
        ...visibleTags.map(
          (category) => Chip(
            label: Text(
              category,
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            side: BorderSide.none,
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        if (extraCount > 0)
          Chip(
            label: Text(
              '+$extraCount',
              style: theme.textTheme.labelSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.grey,
            side: BorderSide.none,
            padding: EdgeInsets.zero,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
      ],
    );
  }
}
