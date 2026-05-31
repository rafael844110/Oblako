import 'package:flutter/material.dart';

class DishesOverview extends StatelessWidget {
  const DishesOverview({super.key, required this.dishes});

  final List<String> dishes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: dishes.length,
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                dishes[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
