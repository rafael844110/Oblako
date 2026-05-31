import 'package:flutter/material.dart';

class RowViewDetails extends StatelessWidget {
  const RowViewDetails({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
