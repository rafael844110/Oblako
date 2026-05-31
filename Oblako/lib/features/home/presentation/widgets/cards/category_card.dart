import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.title,
    required this.image,
  });

  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 120,
          height: 80,
          padding: const EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: theme.textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          top: -20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              image,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
