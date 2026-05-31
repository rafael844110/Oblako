import 'package:cullinarium/features/home/presentation/dummy_data.dart';
import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  const FoodCard({super.key, required this.food});

  final Food food;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size.width * 0.75,
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          decoration: BoxDecoration(
            color: theme.primaryColor,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.name,
                style: theme.textTheme.headlineMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width * 0.35,
                child: Text(
                  food.description,
                  style: theme.textTheme.labelSmall!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/star.png',
                    width: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(food.rating.toString(),
                      style: theme.textTheme.labelSmall),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('${food.price} ₽',
                          style: theme.textTheme.labelSmall),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: -50,
          right: -10,
          child: Image.asset(
            food.image,
            width: 170,
            height: 170,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
