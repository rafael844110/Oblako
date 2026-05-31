import 'dart:async';

import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';

class FakeRecipeRepository implements RecipeRepository {
  final List<RecipeModel> store = [];

  bool shouldThrow = false;

  @override
  Future<void> addRecipe(RecipeModel recipe) async {
    if (shouldThrow) throw Exception('add failed');
    store.add(recipe);
  }

  @override
  Future<void> deleteRecipe(String id) async {
    store.removeWhere((r) => r.id == id);
  }

  @override
  Future<RecipeModel> getRecipeById(String id) async {
    return store.firstWhere((r) => r.id == id);
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    if (shouldThrow) throw Exception('load failed');
    return List.unmodifiable(store);
  }

  @override
  Stream<List<RecipeModel>> recipeStream() async* {
    yield store;
  }

  @override
  Future<void> updateRecipe(RecipeModel recipe) async {
    final idx = store.indexWhere((r) => r.id == recipe.id);
    if (idx >= 0) store[idx] = recipe;
  }
}
