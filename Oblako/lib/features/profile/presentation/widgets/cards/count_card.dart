import 'package:flutter/material.dart';

class CountCard extends StatelessWidget {
  const CountCard({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
  });

  final IconData icon;
  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          children: [
            Icon(icon, size: 32, color: Theme.of(context).primaryColor),
            const SizedBox(height: 8),
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}
