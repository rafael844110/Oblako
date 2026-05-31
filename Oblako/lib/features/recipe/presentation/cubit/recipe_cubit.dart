import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/usecases/add_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/get_recipes_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/update_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_state.dart';
import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class RecipeCubit extends Cubit<RecipeState> {
  final GetRecipesUseCase getRecipes;
  final AddRecipeUseCase addRecipe;
  final UpdateRecipeUseCase updateRecipeRepo;
  final AuthService _authService;

  RecipeCubit({
    required this.getRecipes,
    required this.addRecipe,
    required this.updateRecipeRepo,
    required AuthService authService,
  })  : _authService = authService,
        super(const RecipeState());

  // Recipe List methods
  Future<void> loadRecipes() async {
    emit(state.copyWith(isLoadingRecipes: true, errorMessage: null));

    try {
      final recipes = await getRecipes.execute();
      emit(state.copyWith(recipes: recipes, isLoadingRecipes: false));
    } catch (e) {
      emit(state.copyWith(
        isLoadingRecipes: false,
        errorMessage: 'Failed to load recipes: ${e.toString()}',
      ));
    }
  }

  void selectRecipe(RecipeModel recipe) {
    emit(state.copyWith(selectedRecipe: recipe));
  }

  void clearSelectedRecipe() {
    emit(state.copyWith(selectedRecipe: null));
  }

  // Recipe Form methods
  void resetForm() {
    emit(state.copyWith(
      title: '',
      description: '',
      imageUrl: '',
      categories: const [],
      ingredients: const [],
      steps: const [],
      prepTimeMinutes: 0,
      cookTimeMinutes: 0,
      servings: 1,
      isSubmitting: false,
      isSuccess: false,
      errorMessage: null,
    ));
  }

  void titleChanged(String value) {
    emit(state.copyWith(title: value));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value));
  }

  void imageUrlChanged(String value) {
    emit(state.copyWith(imageUrl: value));
  }

  void categoriesChanged(List<String> value) {
    emit(state.copyWith(categories: value));
  }

  void addCategory(String category) {
    if (category.isNotEmpty && !state.categories.contains(category)) {
      final updatedCategories = List<String>.from(state.categories)
        ..add(category);
      emit(state.copyWith(categories: updatedCategories));
    }
  }

  void removeCategory(String category) {
    final updatedCategories = List<String>.from(state.categories)
      ..removeWhere((item) => item == category);
    emit(state.copyWith(categories: updatedCategories));
  }

  void addIngredient(IngredientModel ingredient) {
    final updatedIngredients = List<IngredientModel>.from(state.ingredients)
      ..add(ingredient);
    emit(state.copyWith(ingredients: updatedIngredients));
  }

  void updateIngredient(int index, IngredientModel ingredient) {
    if (index >= 0 && index < state.ingredients.length) {
      final updatedIngredients = List<IngredientModel>.from(state.ingredients);
      updatedIngredients[index] = ingredient;
      emit(state.copyWith(ingredients: updatedIngredients));
    }
  }

  void removeIngredient(int index) {
    final updatedIngredients = List<IngredientModel>.from(state.ingredients);
    if (index >= 0 && index < updatedIngredients.length) {
      updatedIngredients.removeAt(index);
      emit(state.copyWith(ingredients: updatedIngredients));
    }
  }

  void addStep(String step) {
    if (step.isNotEmpty) {
      final updatedSteps = List<String>.from(state.steps)..add(step);
      emit(state.copyWith(steps: updatedSteps));
    }
  }

  void updateStep(int index, String step) {
    if (index >= 0 && index < state.steps.length && step.isNotEmpty) {
      final updatedSteps = List<String>.from(state.steps);
      updatedSteps[index] = step;
      emit(state.copyWith(steps: updatedSteps));
    }
  }

  void removeStep(int index) {
    final updatedSteps = List<String>.from(state.steps);
    if (index >= 0 && index < updatedSteps.length) {
      updatedSteps.removeAt(index);
      emit(state.copyWith(steps: updatedSteps));
    }
  }

  void reorderSteps(int oldIndex, int newIndex) {
    if (oldIndex < state.steps.length && newIndex < state.steps.length) {
      final updatedSteps = List<String>.from(state.steps);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final step = updatedSteps.removeAt(oldIndex);
      updatedSteps.insert(newIndex, step);
      emit(state.copyWith(steps: updatedSteps));
    }
  }

  void prepTimeChanged(int value) {
    emit(state.copyWith(prepTimeMinutes: value));
  }

  void cookTimeChanged(int value) {
    emit(state.copyWith(cookTimeMinutes: value));
  }

  void servingsChanged(int value) {
    emit(state.copyWith(servings: value));
  }

  Future<void> submitRecipe() async {
    if (state.title.isEmpty ||
        state.ingredients.isEmpty ||
        state.steps.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please fill all required fields'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final currentUser = await _authService.getCurrentUserData();
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      final recipe = RecipeModel(
        id: const Uuid().v4(),
        title: state.title,
        description: state.description,
        authorId: currentUser.id,
        imageUrl: state.imageUrl,
        categories: state.categories,
        ingredients: state.ingredients,
        steps: state.steps,
        prepTimeMinutes: state.prepTimeMinutes,
        cookTimeMinutes: state.cookTimeMinutes,
        servings: state.servings,
        createdAt: DateTime.now(),
        likes: 0,
      );

      await addRecipe.execute(recipe);

      // Update the recipes list with the new recipe
      final updatedRecipes = List<RecipeModel>.from(state.recipes)..add(recipe);

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        recipes: updatedRecipes,
      ));

      // Reset form after successful submission
      resetForm();
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to add recipe: ${e.toString()}',
      ));
    }
  }

  // Loading a recipe into the form for editing
  void loadRecipeForEdit(RecipeModel recipe) {
    emit(state.copyWith(
      title: recipe.title,
      description: recipe.description,
      imageUrl: recipe.imageUrl,
      categories: recipe.categories,
      ingredients: recipe.ingredients,
      steps: recipe.steps,
      prepTimeMinutes: recipe.prepTimeMinutes,
      cookTimeMinutes: recipe.cookTimeMinutes,
      servings: recipe.servings,
      selectedRecipe: recipe,
    ));
  }

  // In recipe_cubit.dart
  Future<void> updateRecipe() async {
    if (state.title.isEmpty ||
        state.ingredients.isEmpty ||
        state.steps.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please fill all required fields'));
      return;
    }

    if (state.selectedRecipe == null) {
      emit(state.copyWith(errorMessage: 'No recipe selected for update'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      final recipe = RecipeModel(
        id: state.selectedRecipe!.id, // Keep the same ID
        title: state.title,
        description: state.description,
        authorId: state.selectedRecipe!.authorId, // Keep the same author
        imageUrl: state.imageUrl,
        categories: state.categories,
        ingredients: state.ingredients,
        steps: state.steps,
        prepTimeMinutes: state.prepTimeMinutes,
        cookTimeMinutes: state.cookTimeMinutes,
        servings: state.servings,
        createdAt:
            state.selectedRecipe!.createdAt, // Keep the original creation date
        likes: state.selectedRecipe!.likes, // Keep the original likes count
      );

      await updateRecipeRepo
          .execute(recipe); // You need to implement this use case

      // Update the recipes list with the updated recipe
      final updatedRecipes = List<RecipeModel>.from(state.recipes);
      final index = updatedRecipes.indexWhere((r) => r.id == recipe.id);
      if (index >= 0) {
        updatedRecipes[index] = recipe;
      }

      emit(state.copyWith(
        isSubmitting: false,
        isSuccess: true,
        recipes: updatedRecipes,
        selectedRecipe: recipe, // Update the selected recipe too
      ));

      // Reset form after successful submission
      resetForm();
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        errorMessage: 'Failed to update recipe: ${e.toString()}',
      ));
    }
  }
}
