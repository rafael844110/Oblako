// lib/presentation/widgets/message_bubble.dart
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isUser;

  const MessageBubble({
    super.key,
    required this.message,
    required this.isUser,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isUser
              ? theme.colorScheme.primary
              : theme.colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display markdown text for the message content
            MarkdownBody(
              data: message.content,
              styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                  color: isUser
                      ? Colors.white
                      : theme.colorScheme.onSecondaryContainer,
                  fontSize: 16.0,
                ),
                code: TextStyle(
                  backgroundColor: isUser
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.tertiaryContainer,
                  color: isUser
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onTertiaryContainer,
                  fontSize: 14.0,
                ),
                codeblockDecoration: BoxDecoration(
                  color: isUser
                      ? theme.colorScheme.primaryContainer.withOpacity(0.7)
                      : theme.colorScheme.tertiaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),

            // Timestamp
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                timeago.format(message.timestamp, locale: 'en_short'),
                style: TextStyle(
                  color: isUser
                      ? Colors.white.withOpacity(0.7)
                      : theme.colorScheme.onSecondaryContainer.withOpacity(0.6),
                  fontSize: 12.0,
                ),
                textAlign: isUser ? TextAlign.right : TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
