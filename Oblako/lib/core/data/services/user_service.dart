import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class UserService {
  static Icon getRoleIcon(String userType) {
    switch (userType) {
      case 'chef':
        return const Icon(Icons.restaurant, size: 16, color: AppColors.primary);
      case 'author':
        return const Icon(Icons.book, size: 16, color: AppColors.primary);
      case 'user':
      default:
        return const Icon(Icons.person, size: 16, color: AppColors.primary);
    }
  }

  static String getRoleDisplayName(String userType) {
    switch (userType) {
      case 'chef':
        return 'Chef';
      case 'author':
        return 'Author';
      case 'user':
      default:
        return 'User';
    }
  }
}
