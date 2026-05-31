import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';

class AddRecipeUseCase {
  final RecipeRepository recipeRepository;

  AddRecipeUseCase(this.recipeRepository);

  Future<void> execute(RecipeModel recipe) async {
    await recipeRepository.addRecipe(recipe);
  }
}
