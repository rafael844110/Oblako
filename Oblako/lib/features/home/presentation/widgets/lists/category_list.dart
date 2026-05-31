import 'package:cullinarium/features/home/presentation/dummy_data.dart';
import 'package:cullinarium/features/home/presentation/widgets/cards/category_card.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(
            'Categories',
            style: theme.textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 100,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CategoryCard(
                  title: category.name,
                  image: category.image,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
