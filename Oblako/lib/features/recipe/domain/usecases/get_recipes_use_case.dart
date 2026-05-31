import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';

class GetRecipesUseCase {
  final RecipeRepository repository;

  GetRecipesUseCase(this.repository);

  Future<List<RecipeModel>> execute() async {
    return await repository.getRecipes();
  }
}
