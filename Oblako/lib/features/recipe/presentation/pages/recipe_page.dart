import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_state.dart';
import 'package:cullinarium/features/recipe/presentation/pages/add_recipe_page.dart';
import 'package:cullinarium/features/recipe/presentation/widgets/cards/recipe_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider.value(
      value: context.read<RecipeCubit>()..loadRecipes(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          BlocBuilder<RecipeCubit, RecipeState>(
            buildWhen: (previous, current) =>
                previous.recipes != current.recipes ||
                previous.isLoadingRecipes != current.isLoadingRecipes ||
                previous.errorMessage != current.errorMessage,
            builder: (context, state) {
              if (state.isLoadingRecipes) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage != null) {
                return Center(child: Text(state.errorMessage!));
              }

              if (state.recipes.isEmpty) {
                return const Center(child: Text('No recipes found'));
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    Text(
                      'Recipes',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.recipes.length,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final recipe = state.recipes[index];
                        return RecipeCard(recipe: recipe);
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          // Positioned(
          //   top: kToolbarHeight,
          //   right: 16,
          //   child: GestureDetector(
          //     child: const Icon(Icons.add),
          //     onTap: () {
          //       context.read<RecipeCubit>().resetForm();
          //       Navigator.of(context).push(
          //         MaterialPageRoute(builder: (_) => const AddRecipePage()),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
