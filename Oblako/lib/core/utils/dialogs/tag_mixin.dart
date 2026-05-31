import 'package:flutter/material.dart';

mixin TagMixin {
  Future<String?> showAddTagDialog({
    required BuildContext context,
    String title = 'Add tag',
  }) {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Enter tag'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final value = controller.text.trim();
              Navigator.pop(context, value.isEmpty ? null : value);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
