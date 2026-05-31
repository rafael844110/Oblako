import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IngredientModel', () {
    test('toJson <-> fromJson preserves values', () {
      final json = {'name': 'Sugar', 'quantity': 1.5, 'unit': 'cup'};
      final model = IngredientModel.fromJson(json);

      expect(model.name, 'Sugar');
      expect(model.quantity, 1.5);
      expect(model.unit, 'cup');
      expect(model.toJson(), json);
    });
  });

  group('RecipeModel', () {
    final createdAt = DateTime.utc(2024, 5, 1, 12);

    final json = {
      'id': 'r-1',
      'title': 'Pancakes',
      'description': 'Fluffy pancakes',
      'authorId': 'u-1',
      'imageUrl': 'https://img/p.jpg',
      'categories': ['breakfast', 'sweet'],
      'ingredients': [
        {'name': 'Flour', 'quantity': 2.0, 'unit': 'cup'},
        {'name': 'Milk', 'quantity': 1.0, 'unit': 'cup'},
      ],
      'steps': ['Mix', 'Cook'],
      'prepTimeMinutes': 5,
      'cookTimeMinutes': 10,
      'servings': 2,
      'createdAt': createdAt.toIso8601String(),
      'likes': 7,
    };

    test('fromJson maps every field', () {
      final r = RecipeModel.fromJson(json);

      expect(r.id, 'r-1');
      expect(r.title, 'Pancakes');
      expect(r.authorId, 'u-1');
      expect(r.categories, ['breakfast', 'sweet']);
      expect(r.ingredients.length, 2);
      expect(r.ingredients.first.name, 'Flour');
      expect(r.steps, ['Mix', 'Cook']);
      expect(r.prepTimeMinutes, 5);
      expect(r.cookTimeMinutes, 10);
      expect(r.servings, 2);
      expect(r.createdAt, createdAt);
      expect(r.likes, 7);
    });

    test('toJson roundtrip equality', () {
      final r = RecipeModel.fromJson(json);
      final out = r.toJson();
      expect(out['title'], json['title']);
      expect(out['categories'], json['categories']);
      expect(out['steps'], json['steps']);
      expect(out['ingredients'], json['ingredients']);
      expect(out['createdAt'], createdAt.toIso8601String());
    });

    test('fromJson accepts DateTime instance (mock path)', () {
      final mockJson = Map<String, dynamic>.from(json);
      mockJson['createdAt'] = createdAt;
      final r = RecipeModel.fromJson(mockJson);
      expect(r.createdAt, createdAt);
    });
  });
}
