import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onSend;
  final bool isLoading;
  final bool enabled; // Added enabled property

  const ChatInput({
    Key? key,
    required this.controller,
    required this.onSend,
    this.isLoading = false,
    this.enabled = true, // Default to enabled
  }) : super(key: key);

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateHasText);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateHasText);
    super.dispose();
  }

  void _updateHasText() {
    final hasText = widget.controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _handleSend() {
    if (widget.controller.text.trim().isNotEmpty &&
        !widget.isLoading &&
        widget.enabled) {
      widget.onSend(widget.controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 3.0,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Text input field
          Expanded(
            child: TextField(
              controller: widget.controller,
              enabled: widget.enabled &&
                  !widget.isLoading, // Disable when not enabled or loading
              minLines: 1,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: widget.enabled
                    ? 'Type a message...'
                    : 'Waiting for response...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: widget.enabled
                    ? theme.colorScheme.surfaceVariant.withOpacity(0.5)
                    : theme.colorScheme.surfaceVariant.withOpacity(0.3),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
              ),
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              onSubmitted: (value) {
                if (_hasText && widget.enabled) {
                  _handleSend();
                }
              },
            ),
          ),

          // Send button
          AnimatedOpacity(
            opacity: (widget.isLoading || !widget.enabled) ? 0.5 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: _hasText && widget.enabled
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withOpacity(0.4),
              ),
              onPressed: (_hasText && widget.enabled && !widget.isLoading)
                  ? _handleSend
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
