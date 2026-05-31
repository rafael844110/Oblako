// lib/presentation/pages/recipe_detail_page.dart with CustomScrollView and Slivers
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/features/recipe/presentation/widgets/cards/cooking_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_state.dart';
import 'package:cullinarium/features/recipe/presentation/pages/add_recipe_page.dart';

class RecipeDetailPage extends StatelessWidget {
  const RecipeDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RecipeCubit, RecipeState>(
      buildWhen: (previous, current) =>
          previous.selectedRecipe != current.selectedRecipe,
      builder: (context, state) {
        final recipe = state.selectedRecipe;

        if (recipe == null) {
          return const Scaffold(
            body: Center(
              child: Text('Recipe not found'),
            ),
          );
        }

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                expandedHeight: recipe.imageUrl.isNotEmpty ? 250.0 : 0.0,
                backgroundColor: AppColors.primary,
                flexibleSpace: FlexibleSpaceBar(
                  background: recipe.imageUrl.isNotEmpty
                      ? Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
                title: Text(
                  'Recipe Details',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                // actions: [
                //   IconButton(
                //     icon: const Icon(
                //       Icons.edit,
                //       color: Colors.white,
                //     ),
                //     onPressed: () {
                //       Navigator.of(context).push(
                //         MaterialPageRoute(
                //           builder: (_) => const AddRecipePage(
                //             isEditMode: true,
                //           ),
                //         ),
                //       );
                //     },
                //   ),
                // ],
              ),

              // Content
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Text(
                      recipe.title,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),

                    if (recipe.description.isNotEmpty) ...[
                      Text(
                        recipe.description,
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Recipe info cards
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: CookingInfo(
                            icon: Icons.timer_outlined,
                            title: 'Prep Time',
                            value: '${recipe.prepTimeMinutes} min',
                          ),
                        ),
                        Expanded(
                          child: CookingInfo(
                            icon: Icons.microwave_outlined,
                            title: 'Cook Time',
                            value: '${recipe.cookTimeMinutes} min',
                          ),
                        ),
                        Expanded(
                          child: CookingInfo(
                            icon: Icons.people_outline,
                            title: 'Servings',
                            value: recipe.servings.toString(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Categories
                    if (recipe.categories.isNotEmpty) ...[
                      Text(
                        'Categories',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 0,
                        children: recipe.categories
                            .map(
                              (category) => Chip(
                                label: Text(
                                  category,
                                  style: theme.textTheme.labelMedium,
                                ),
                                backgroundColor: AppColors.primary.shade50,
                                side: BorderSide.none,
                              ),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Ingredients
                    Text(
                      'Ingredients',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...recipe.ingredients.map((ingredient) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.fiber_manual_record, size: 12),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${ingredient.quantity} ${ingredient.unit} ${ingredient.name}',
                                style: theme.textTheme.headlineSmall,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height: 24),

                    // Steps
                    Text(
                      'Instructions',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(recipe.steps.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: AppColors.primary.shade300,
                              child: Text(
                                '${index + 1}',
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Text(
                                recipe.steps[index],
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ]),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
