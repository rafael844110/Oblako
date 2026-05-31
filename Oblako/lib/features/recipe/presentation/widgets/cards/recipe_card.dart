import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:cullinarium/features/recipe/presentation/pages/recipe_details_page.dart';
import 'package:cullinarium/features/recipe/presentation/widgets/utils/recipe_tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;

class RecipeCard extends StatelessWidget {
  final RecipeModel recipe;

  const RecipeCard({
    super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalTime = recipe.prepTimeMinutes + recipe.cookTimeMinutes;

    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          context.read<RecipeCubit>().selectRecipe(recipe);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const RecipeDetailPage(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe image with overlay gradient and categories
            Stack(
              children: [
                SizedBox(
                  height: 180,
                  width: double.infinity,
                  child: recipe.imageUrl.isNotEmpty
                      ? Image.network(
                          recipe.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[300],
                            child: const Icon(Icons.broken_image, size: 50),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              color: Colors.grey[200],
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                        )
                      : Container(
                          color: Colors.grey[300],
                          child: const Icon(Icons.image, size: 50),
                        ),
                ),

                // Gradient overlay for better text visibility
                const Positioned.fill(
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black54,
                        ],
                        stops: [0.6, 1.0],
                      ),
                    ),
                  ),
                ),

                // Recipe title and time
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe.title,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              totalTime > 0 ? '$totalTime min' : 'Quick recipe',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                // Categories chips
                if (recipe.categories.isNotEmpty)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: RecipeTags(tags: recipe.categories),
                  ),
              ],
            ),

            // Recipe metadata
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (recipe.description.isNotEmpty) ...[
                    Text(
                      recipe.description,
                      style: theme.textTheme.headlineSmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                  ],

                  // Recipe info row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Servings info
                      Row(
                        children: [
                          const Icon(Icons.people_outline, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${recipe.servings} servings',
                            style: theme.textTheme.labelSmall,
                          ),
                        ],
                      ),

                      // Likes counter
                      // Row(
                      //   children: [
                      //     Icon(
                      //       Icons.favorite,
                      //       size: 16,
                      //       color: recipe.likes > 0
                      //           ? Colors.redAccent
                      //           : Colors.grey,
                      //     ),
                      //     const SizedBox(width: 4),
                      //     Text(
                      //       recipe.likes.toString(),
                      //       style: theme.textTheme.bodySmall,
                      //     ),
                      //   ],
                      // ),

                      // Recipe date
                      Text(
                        timeago.format(recipe.createdAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  // Ingredient preview
                  if (recipe.ingredients.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Ingredients: ${recipe.ingredients.length}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
