import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.textStyle,
    this.width = 200,
    this.margin,
    this.padding,
    this.isDisabled = false,
  });

  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final TextStyle? textStyle;
  final double width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: isDisabled ? null : onPressed,
      child: Container(
        width: width,
        margin: margin,
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey : (color ?? AppColors.primary),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ??
                theme.textTheme.headlineSmall!.copyWith(
                  color: isDisabled ? Colors.black38 : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
