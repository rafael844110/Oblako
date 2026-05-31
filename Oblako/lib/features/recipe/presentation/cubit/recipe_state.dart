import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:equatable/equatable.dart';

class RecipeState extends Equatable {
  // Recipe List properties
  final List<RecipeModel> recipes;
  final bool isLoadingRecipes;

  // Recipe Form properties
  final String title;
  final String description;
  final String imageUrl;
  final List<String> categories;
  final List<IngredientModel> ingredients;
  final List<String> steps;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final bool isSubmitting;
  final bool isSuccess;

  // Shared properties
  final String? errorMessage;
  final RecipeModel? selectedRecipe;

  const RecipeState({
    // Recipe List properties
    this.recipes = const [],
    this.isLoadingRecipes = false,

    // Recipe Form properties
    this.title = '',
    this.description = '',
    this.imageUrl = '',
    this.categories = const [],
    this.ingredients = const [],
    this.steps = const [],
    this.prepTimeMinutes = 0,
    this.cookTimeMinutes = 0,
    this.servings = 1,
    this.isSubmitting = false,
    this.isSuccess = false,

    // Shared properties
    this.errorMessage,
    this.selectedRecipe,
  });

  RecipeState copyWith({
    List<RecipeModel>? recipes,
    bool? isLoadingRecipes,
    String? title,
    String? description,
    String? imageUrl,
    List<String>? categories,
    List<IngredientModel>? ingredients,
    List<String>? steps,
    int? prepTimeMinutes,
    int? cookTimeMinutes,
    int? servings,
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
    RecipeModel? selectedRecipe,
  }) {
    return RecipeState(
      recipes: recipes ?? this.recipes,
      isLoadingRecipes: isLoadingRecipes ?? this.isLoadingRecipes,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      categories: categories ?? this.categories,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      servings: servings ?? this.servings,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      selectedRecipe: selectedRecipe ?? this.selectedRecipe,
    );
  }

  @override
  List<Object?> get props => [
        recipes,
        isLoadingRecipes,
        title,
        description,
        imageUrl,
        categories,
        ingredients,
        steps,
        prepTimeMinutes,
        cookTimeMinutes,
        servings,
        isSubmitting,
        isSuccess,
        errorMessage,
        selectedRecipe,
      ];
}
