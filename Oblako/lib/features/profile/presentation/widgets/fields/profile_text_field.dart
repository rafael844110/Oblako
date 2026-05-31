import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    super.key,
    required this.label,
    this.hintText,
    required this.controller,
    this.maxLines,
    this.keyboardType,
    this.onChanged,
  });

  final String label;
  final String? hintText;
  final TextEditingController controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        hintText: widget.hintText ?? 'Tell us about yourself',
        border: const OutlineInputBorder(),
      ),
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      // Make sure the text field updates when the controller value changes externally
      key: ValueKey(widget.controller.hashCode),
    );
  }
}
