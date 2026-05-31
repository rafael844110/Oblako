import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDetailedField extends StatelessWidget {
  const AppDetailedField({
    super.key,
    required this.title,
    required this.hint,
    required this.controller,
    required this.icon,
  });

  final String title;
  final String hint;
  final TextEditingController controller;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
        hintText: hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
            width: 1.0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(
            color: AppColors.primary,
            width: 1.0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          borderSide: BorderSide(
            color: AppColors.lightGrey,
            width: 1.0,
          ),
        ),
        prefixIcon: Icon(icon),
      ),
    );
  }
}
