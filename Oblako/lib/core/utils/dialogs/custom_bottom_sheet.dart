import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin CustomBottomSheets {
  void showImagePickerSheet({
    required BuildContext context,
    required VoidCallback onPickFromGallery,
    required VoidCallback onPickFromCamera,
  }) {
    final theme = Theme.of(context);
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              onPickFromGallery();
            },
            child: Text(
              'Media library',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              onPickFromCamera();
            },
            child: Text(
              'Camera',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  void showEditPickerSheet({
    required BuildContext context,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) {
    final theme = Theme.of(context);
    showCupertinoModalPopup(
      context: context,
      builder: (_) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () {
              onEdit();
            },
            child: Text(
              'Edit',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.blue,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              onDelete();
            },
            child: Text(
              'Delete',
              style: theme.textTheme.titleMedium?.copyWith(
                color: Colors.red,
              ),
            ),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context),
          child: Text(
            'Cancel',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
