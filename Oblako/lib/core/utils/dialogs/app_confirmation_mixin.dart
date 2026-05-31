import 'package:flutter/material.dart';

mixin AppConfirmationMixin<T extends StatefulWidget> on State<T> {
  Future<bool> showConfirmationDialog({
    required String title,
    required String content,
    String confirmText = 'Yes',
    String cancelText = 'No',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );

    return result ?? false;
  }

  Future<bool> confirmLogout() {
    return showConfirmationDialog(
      title: 'Logout',
      content: 'Are you sure you want to logout?',
    );
  }

  Future<bool> confirmLeave() {
    return showConfirmationDialog(
      title: 'Leave Page',
      content: 'Are you sure you want to leave this page?',
    );
  }
}
