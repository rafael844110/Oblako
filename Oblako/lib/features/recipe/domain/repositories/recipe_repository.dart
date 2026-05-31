import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';

abstract class RecipeRepository {
  Future<List<RecipeModel>> getRecipes();
  Future<RecipeModel> getRecipeById(String id);
  Future<void> addRecipe(RecipeModel recipe);
  Future<void> updateRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(String id);
  Stream<List<RecipeModel>> recipeStream();
}
