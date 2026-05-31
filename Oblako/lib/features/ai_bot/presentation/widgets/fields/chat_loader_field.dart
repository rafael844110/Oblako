import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatLoaderField extends StatelessWidget {
  const ChatLoaderField({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: theme.colorScheme.surface.withOpacity(0.7),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                'C',
                style: TextStyle(
                  color: theme.colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(18),
              ),
              child: LoadingAnimationWidget.waveDots(
                color: Colors.white,
                size: 24,
              )),
        ],
      ),
    );
  }
}
