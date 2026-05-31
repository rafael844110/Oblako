import 'package:cullinarium/features/home/presentation/dummy_data.dart';
import 'package:cullinarium/features/home/presentation/widgets/cards/food_card.dart';
import 'package:flutter/material.dart';

class PopularFoodList extends StatelessWidget {
  const PopularFoodList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Popular',
          style: theme.textTheme.headlineLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 190,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 20),
            scrollDirection: Axis.horizontal,
            itemCount: popularFoods.length,
            itemBuilder: (context, index) {
              final food = popularFoods[index];
              return FoodCard(
                food: food,
              );
            },
          ),
        )
      ],
    );
  }
}
