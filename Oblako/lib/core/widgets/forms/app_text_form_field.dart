import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  const AppTextFormField({
    super.key,
    required this.title,
    this.hintext,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
  });

  final String title;
  final String? hintext;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        obscureText: _isObscured,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.title,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIcon ??
              (widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _isObscured
                            ? Icons.visibility_rounded
                            : Icons.visibility_off_rounded,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscured = !_isObscured;
                        });
                      },
                    )
                  : null),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
