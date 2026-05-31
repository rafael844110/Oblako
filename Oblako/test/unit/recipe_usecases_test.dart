import 'package:cullinarium/features/recipe/domain/usecases/add_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/get_recipes_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/update_recipe_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/fake_recipe_repository.dart';
import '../helpers/recipe_factory.dart';

void main() {
  late FakeRecipeRepository repo;

  setUp(() {
    repo = FakeRecipeRepository();
  });

  group('AddRecipeUseCase', () {
    test('persists recipe through repository', () async {
      final useCase = AddRecipeUseCase(repo);
      await useCase.execute(buildRecipe(id: 'a-1'));
      expect(repo.store.single.id, 'a-1');
    });

    test('propagates repository error', () {
      repo.shouldThrow = true;
      final useCase = AddRecipeUseCase(repo);
      expect(useCase.execute(buildRecipe()), throwsException);
    });
  });

  group('GetRecipesUseCase', () {
    test('returns recipes from repository', () async {
      await repo.addRecipe(buildRecipe(id: 'g-1'));
      await repo.addRecipe(buildRecipe(id: 'g-2'));

      final list = await GetRecipesUseCase(repo).execute();
      expect(list.length, 2);
      expect(list.map((r) => r.id), containsAll(['g-1', 'g-2']));
    });
  });

  group('UpdateRecipeUseCase', () {
    test('replaces existing recipe with same id', () async {
      await repo.addRecipe(buildRecipe(id: 'u-1', title: 'old'));
      await UpdateRecipeUseCase(repo)
          .execute(buildRecipe(id: 'u-1', title: 'new'));
      expect(repo.store.single.title, 'new');
    });

    test('no-op when id missing', () async {
      await UpdateRecipeUseCase(repo).execute(buildRecipe(id: 'ghost'));
      expect(repo.store, isEmpty);
    });
  });
}
