// Integration test — recipe-form happy path without Firebase.
//
// We exercise the field-mutation surface of RecipeCubit through a host
// MaterialApp built around a small test screen. Firebase / AuthService is
// intentionally NOT initialized; we cover the form interactions that fall
// outside the submitRecipe() path.

import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';
import 'package:cullinarium/features/recipe/domain/usecases/add_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/get_recipes_use_case.dart';
import 'package:cullinarium/features/recipe/domain/usecases/update_recipe_use_case.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_state.dart';
import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

class _FakeRepo implements RecipeRepository {
  final List<RecipeModel> _store = [];
  @override
  Future<void> addRecipe(RecipeModel recipe) async => _store.add(recipe);
  @override
  Future<void> deleteRecipe(String id) async =>
      _store.removeWhere((r) => r.id == id);
  @override
  Future<RecipeModel> getRecipeById(String id) async =>
      _store.firstWhere((r) => r.id == id);
  @override
  Future<List<RecipeModel>> getRecipes() async => List.unmodifiable(_store);
  @override
  Stream<List<RecipeModel>> recipeStream() async* {
    yield _store;
  }

  @override
  Future<void> updateRecipe(RecipeModel recipe) async {
    final i = _store.indexWhere((r) => r.id == recipe.id);
    if (i >= 0) _store[i] = recipe;
  }
}

class _StubAuthService implements AuthService {
  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _RecipeFormScreen extends StatelessWidget {
  const _RecipeFormScreen();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecipeCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Add Recipe')),
      body: BlocBuilder<RecipeCubit, RecipeState>(
        builder: (_, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  key: const Key('title-field'),
                  onChanged: cubit.titleChanged,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('Steps: ${state.steps.length}'),
                    const SizedBox(width: 12),
                    Text('Ingredients: ${state.ingredients.length}'),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  key: const Key('add-step'),
                  onPressed: () => cubit.addStep('Step ${state.steps.length}'),
                  child: const Text('Add step'),
                ),
                ElevatedButton(
                  key: const Key('add-ingredient'),
                  onPressed: () => cubit.addIngredient(
                    IngredientModel(
                      name: 'Item ${state.ingredients.length}',
                      quantity: 1,
                      unit: 'pcs',
                    ),
                  ),
                  child: const Text('Add ingredient'),
                ),
                ElevatedButton(
                  key: const Key('reset'),
                  onPressed: cubit.resetForm,
                  child: const Text('Reset'),
                ),
                if (state.title.isNotEmpty)
                  Text('Current title: ${state.title}',
                      key: const Key('title-echo')),
              ],
            ),
          );
        },
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('user can fill title + add steps + ingredients, then reset',
      (tester) async {
    final repo = _FakeRepo();
    final cubit = RecipeCubit(
      getRecipes: GetRecipesUseCase(repo),
      addRecipe: AddRecipeUseCase(repo),
      updateRecipeRepo: UpdateRecipeUseCase(repo),
      authService: _StubAuthService(),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cubit,
          child: const _RecipeFormScreen(),
        ),
      ),
    );

    await tester.enterText(find.byKey(const Key('title-field')), 'Pancakes');
    await tester.pump();
    expect(find.byKey(const Key('title-echo')), findsOneWidget);
    expect(cubit.state.title, 'Pancakes');

    for (var i = 0; i < 3; i++) {
      await tester.tap(find.byKey(const Key('add-step')));
      await tester.pump();
    }
    expect(cubit.state.steps.length, 3);
    expect(find.text('Steps: 3'), findsOneWidget);

    for (var i = 0; i < 2; i++) {
      await tester.tap(find.byKey(const Key('add-ingredient')));
      await tester.pump();
    }
    expect(cubit.state.ingredients.length, 2);
    expect(find.text('Ingredients: 2'), findsOneWidget);

    await tester.tap(find.byKey(const Key('reset')));
    await tester.pump();
    expect(cubit.state.steps, isEmpty);
    expect(cubit.state.ingredients, isEmpty);
    expect(cubit.state.title, '');
  });
}
