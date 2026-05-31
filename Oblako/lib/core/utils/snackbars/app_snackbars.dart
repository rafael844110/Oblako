import 'package:flutter/material.dart';

mixin AppSnackbars {
  void showErrorSnackbar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Makes the snackbar floating
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Adds rounded corners
        ),
      ),
    );
  }

  void showSuccessSnackbar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating, // Makes the snackbar floating
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Adds rounded corners
        ),
      ),
    );
  }
}
