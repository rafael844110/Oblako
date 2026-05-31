import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';

RecipeModel buildRecipe({
  String id = 'r-1',
  String title = 'Test Recipe',
  String authorId = 'u-1',
  int likes = 0,
}) {
  return RecipeModel(
    id: id,
    title: title,
    description: 'desc',
    authorId: authorId,
    imageUrl: '',
    categories: const ['test'],
    ingredients: [
      IngredientModel(name: 'salt', quantity: 1, unit: 'tsp'),
    ],
    steps: const ['mix'],
    prepTimeMinutes: 5,
    cookTimeMinutes: 10,
    servings: 2,
    createdAt: DateTime.utc(2024, 1, 1),
    likes: likes,
  );
}
