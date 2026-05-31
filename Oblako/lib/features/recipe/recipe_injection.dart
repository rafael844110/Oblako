import 'package:cullinarium/features/recipe/data/repositories/recipe_repository_impl.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:cullinarium/features/recipe/domain/usecases/add_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/get_recipes_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/update_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:cullinarium/core/data/local/mock_database.dart';

void recipeInjection() {
  final sl = GetIt.instance;

  // Cubit
  sl.registerFactory(
    () => RecipeCubit(
      getRecipes: sl(),
      addRecipe: sl(),
      updateRecipeRepo: sl(),
      authService: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetRecipesUseCase(sl()));
  sl.registerLazySingleton(() => AddRecipeUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRecipeUseCase(sl()));

  // Repository
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(sl<MockDatabase>()),
  );
}
