import 'package:flutter/material.dart';

mixin ConfirmationDialogs {
  Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String content,
    String cancelText = 'Cancel',
    String confirmText = 'Confirm',
    Color confirmColor = Colors.red,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              confirmText,
              style: TextStyle(color: confirmColor),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> showDiscardConfirmationDialog({
    required BuildContext context,
    String cancelText = 'Cancel',
    String confirmText = 'Discard',
  }) {
    return showConfirmationDialog(
      context: context,
      title: 'Discard Changes?',
      content:
          'You have unsaved changes. Are you sure you want to discard them?',
      cancelText: cancelText,
      confirmText: 'Discard',
      confirmColor: Colors.red,
    );
  }
}
