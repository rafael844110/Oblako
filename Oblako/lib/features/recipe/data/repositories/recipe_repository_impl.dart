import 'dart:async';

import 'package:cullinarium/core/data/local/mock_database.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final MockDatabase _db;
  final _recipeStreamController =
      StreamController<List<RecipeModel>>.broadcast();

  RecipeRepositoryImpl(this._db) {
    // Initialize stream with current data
    _recipeStreamController.add(_db.recipes);
  }

  void _updateStream() {
    _recipeStreamController.add(_db.recipes);
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _db.recipes;
  }

  @override
  Future<RecipeModel> getRecipeById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _db.recipes.firstWhere((r) => r.id == id);
    } catch (e) {
      throw Exception('Recipe not found');
    }
  }

  @override
  Future<void> addRecipe(RecipeModel recipe) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _db.recipes.add(recipe);
    _updateStream();
  }

  @override
  Future<void> updateRecipe(RecipeModel recipe) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _db.recipes.indexWhere((r) => r.id == recipe.id);
    if (index != -1) {
      _db.recipes[index] = recipe;
      _updateStream();
    } else {
      throw Exception('Recipe not found to update');
    }
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _db.recipes.removeWhere((r) => r.id == id);
    _updateStream();
  }

  @override
  Stream<List<RecipeModel>> recipeStream() {
    return _recipeStreamController.stream;
  }
}
