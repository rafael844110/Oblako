import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';

class RecipeModel {
  final String id;
  final String title;
  final String description;
  final String authorId;
  final String imageUrl;
  final List<String> categories;
  final List<IngredientModel> ingredients;
  final List<String> steps;
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final DateTime createdAt;
  final int likes;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.authorId,
    required this.imageUrl,
    required this.categories,
    required this.ingredients,
    required this.steps,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.createdAt,
    required this.likes,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      authorId: json['authorId'] as String,
      imageUrl: json['imageUrl'] as String,
      categories: List<String>.from(json['categories']),
      ingredients: (json['ingredients'] as List)
          .map((i) => IngredientModel.fromJson(i))
          .toList(),
      steps: List<String>.from(json['steps']),
      prepTimeMinutes: json['prepTimeMinutes'] as int,
      cookTimeMinutes: json['cookTimeMinutes'] as int,
      servings: json['servings'] as int,
      createdAt: json['createdAt'] is String
          ? DateTime.parse(json['createdAt'] as String)
          : (json['createdAt'] as DateTime), // Handle both for mock/json
      likes: json['likes'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'authorId': authorId,
      'imageUrl': imageUrl,
      'categories': categories,
      'ingredients': ingredients.map((i) => (i).toJson()).toList(),
      'steps': steps,
      'prepTimeMinutes': prepTimeMinutes,
      'cookTimeMinutes': cookTimeMinutes,
      'servings': servings,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes,
    };
  }
}
