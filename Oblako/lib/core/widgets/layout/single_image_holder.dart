import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class SingleImageHolder extends StatelessWidget {
  final File? image;
  final VoidCallback onPick;
  final VoidCallback onRemove;

  const SingleImageHolder({
    super.key,
    required this.image,
    required this.onPick,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 120,
      height: 150,
      child: Stack(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(8),
            dashPattern: const [6, 3],
            color: Colors.grey.shade300,
            strokeWidth: 1.5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: image == null
                  ? InkWell(
                      onTap: onPick,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 35,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.grey.shade400,
                              size: 32,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Add photo',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: onPick,
                      child: SizedBox.expand(
                        child: Image.file(image!, fit: BoxFit.cover),
                      ),
                    ),
            ),
          ),
          if (image != null)
            Positioned(
              top: 2,
              right: 2,
              child: GestureDetector(
                onTap: onRemove,
                child: const Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
