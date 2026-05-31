# Code Map — Main Files & Snippets

Screenshot-ready reference. 15 core files showing app architecture: entry → DI → routing → auth → AI bot → chef → recipe → profile → tests.

---

## 1. Entry & Bootstrap

### `lib/main.dart`

App entry point. Initializes Firebase, runs DI, launches root `App` widget.

```dart
import 'package:cullinarium/features/app/presentation/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/di/injections.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await injections();
  runApp(const App());
}
```

### `lib/core/di/injections.dart`

GetIt service locator. Registers router, SharedPreferences, MockDatabase, delegates per-feature injection.

```dart
import 'package:cullinarium/core/data/local/mock_database.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/features/authentication/auth_injection.dart';
import 'package:cullinarium/features/chef/chef_injection.dart';
import 'package:cullinarium/features/profile/profile_injection.dart';
import 'package:cullinarium/features/recipe/recipe_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> injections() async {
  sl.registerLazySingleton<AppRouter>(() => AppRouter());

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  sl.registerLazySingleton<MockDatabase>(() => MockDatabase());

  await authInjection();
  profileInjection();
```

### `lib/core/navigation/app_router.dart`

AutoRoute configuration. Declares full navigation graph: splash, login, signup, home, profile.

```dart
import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/widgets/layout/app_bottom_page.dart';
import 'package:cullinarium/features/authentication/presentation/pages/login_page.dart';
import 'package:cullinarium/features/authentication/presentation/pages/signup_page.dart';
import 'package:cullinarium/features/authentication/presentation/splash_screen.dart';
import 'package:cullinarium/features/home/presentation/pages/home_page.dart';
import 'package:cullinarium/features/profile/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, path: '/', initial: true),
        AutoRoute(page: LoginRoute.page, path: '/login'),
```

---

## 2. Authentication

### `lib/features/authentication/data/datasources/remote/auth_service.dart`

Firebase Auth + Firestore integration. Caches domain model to avoid race with `authStateChanges`.

```dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  // Cached domain model — set after signUp/signIn so authChanges doesn't
  // race against the Firestore write.
  dynamic _cachedUser;

  AuthService(this._auth, this._firestore);

  User? get currentUser => _auth.currentUser;

  Stream<dynamic> get authChanges =>
      _auth.authStateChanges().asyncMap((user) async {
        if (user == null) {
          _cachedUser = null;
          return null;
        }
        if (_cachedUser != null) return _cachedUser;
        return await _fetchUserData(user.uid);
```

### `lib/features/authentication/presentation/cubit/auth_cubit.dart`

BLoC managing auth state. Subscribes to `authChanges` stream, loads initial user.

```dart
import 'dart:async';

import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  late final StreamSubscription<dynamic> _authSub;

  AuthCubit({required AuthService authService})
      : _authService = authService,
        super(AuthState(isLoading: true)) {
    _authSub = _authService.authChanges.listen(_onAuthStateChanged);
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      var currentUser = await _authService.getCurrentUserData();
```

---

## 3. AI Bot (Chef Curry)

### `lib/features/ai_bot/data/datasources/remote/chat_api_data_source.dart`

HTTP client for Llama 3.3 chat completion API.

```dart
import 'package:cullinarium/core/utils/constants/api_const.dart';
import 'package:cullinarium/features/ai_bot/data/exeptions/chat_api_exeption.dart';
import 'package:cullinarium/features/ai_bot/data/mappers/message_mapper.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class ChatApiDataSource {
  final http.Client client;

  ChatApiDataSource({
    http.Client? client,
  }) : client = client ?? http.Client();

  Future<MessageModel> sendMessage({
    required List<MessageModel> messages,
    String model = "meta-llama/Llama-3.3-70B-Instruct",
    double temperature = 0.7,
  }) async {
    const url = '${ApiConst.baseUrl}/chat/completions';
```

### `lib/features/ai_bot/presentation/cubit/ai_bot_cubit.dart`

BLoC orchestrating chat use cases: send, get, save, delete.

```dart
import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class AiBotCubit extends Cubit<AiBotState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetChatsUseCase getChatUseCase;
  final SaveChatUseCase saveChatUseCase;
  final DeleteChatUseCase deleteChatUseCase;
  final ChatRepository chatRepository;

  AiBotCubit({
    required this.sendMessageUseCase,
    required this.getChatUseCase,
    required this.saveChatUseCase,
    required this.deleteChatUseCase,
    required this.chatRepository,
  }) : super(AiBotState.initial());
```

---

## 4. Chef

### `lib/features/chef/presentation/cubit/chef_cubit.dart`

Chef listing cubit. Uses `Either` for fold-style error handling.

```dart
import 'package:cullinarium/features/chef/domain/usecases/get_all_chefs.dart';
import 'package:equatable/equatable.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chef_state.dart';

class ChefCubit extends Cubit<ChefState> {
  final GetAllChefs getAllChefs;

  ChefCubit({required this.getAllChefs}) : super(ChefInitial());

  Future<void> fetchChefs() async {
    emit(ChefLoading());
    final result = await getAllChefs.call();

    result.fold(
      (error) => emit(ChefError(error)),
      (chefs) => emit(ChefLoaded(chefs)),
    );
  }
}
```

---

## 5. Recipe

### `lib/features/recipe/data/models/recipe_model.dart`

Recipe domain model with ingredients, steps, timings, likes.

```dart
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
```

### `lib/features/recipe/data/repositories/recipe_repository_impl.dart`

Recipe repository with broadcast stream for live list updates.

```dart
import 'dart:async';

import 'package:cullinarium/core/data/local/mock_database.dart';
import 'package:cullinarium/features/recipe/data/models/recipe_model.dart';
import 'package:cullinarium/features/recipe/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final MockDatabase _db;
  final _recipeStreamController =
      StreamController<List<RecipeModel>>.broadcast();

  RecipeRepositoryImpl(this._db) {
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
```

### `lib/features/recipe/presentation/cubit/recipe_cubit.dart`

CRUD cubit. Holds form + list state. Resolves author via `AuthService`.

```dart
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
```

---

## 6. Profile

### `lib/features/profile/data/datasources/profile_service.dart`

Firestore reads across `chefs`, `users`, `authors` collections.

```dart
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/core/data/local/mock_database.dart';
import 'package:cullinarium/features/profile/data/mappers/author_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';

class ProfileService {
  final MockDatabase _db;
  final FirebaseFirestore _firestore;

  ProfileService(this._db, this._firestore);

  Future<dynamic> fetchProfile(String uid) async {
    final chefDoc = await _firestore.collection('chefs').doc(uid).get();
    if (chefDoc.exists) {
      final data = chefDoc.data()!;
      data['id'] = uid;
      return ChefMapper.fromJson(data);
    }

    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      final data = userDoc.data()!;
```

### `lib/features/profile/presentation/cubit/profile_cubit.dart`

Profile cubit. Listens to `AuthCubit` stream to reload profile on auth change.

```dart
import 'dart:io';

import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';
import 'package:cullinarium/features/profile/data/repositories/profile_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final AuthCubit _authCubit;
  final ProfileRepository profileRepository;

  ProfileCubit({
    required AuthCubit authCubit,
    required ProfileRepository profileService,
  })  : _authCubit = authCubit,
        profileRepository = profileService,
        super(ProfileInitial()) {
    initialize();
    _authCubit.stream.listen((authState) {
      if (authState.isAuthenticated && authState.user != null) {
```

---

## 7. Tests

### `test/unit/recipe_usecases_test.dart`

Unit tests for `AddRecipeUseCase`, `GetRecipesUseCase`, `UpdateRecipeUseCase`.

```dart
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
```

### `test/widget/app_button_test.dart`

Widget test verifying `AppButton` rendering and tap callback.

```dart
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) =>
    MaterialApp(home: Scaffold(body: Center(child: child)));

void main() {
  group('AppButton', () {
    testWidgets('renders title text', (tester) async {
      await tester.pumpWidget(
        _host(AppButton(title: 'Tap me', onPressed: () {})),
      );

      expect(find.text('Tap me'), findsOneWidget);
    });

    testWidgets('invokes onPressed when tapped', (tester) async {
      var tapped = 0;
      await tester.pumpWidget(
        _host(AppButton(title: 'Go', onPressed: () => tapped++)),
      );

      await tester.tap(find.text('Go'));
      await tester.pump();
```

### `integration_test/ai_bot_flow_test.dart`

End-to-end chat round-trip with fake repository. Verifies `messageSending → messageSent` flow.

```dart
// Integration test — AI chat round-trip with a fake repository.
//
// Boots a host MaterialApp containing a minimal chat screen and verifies
// that typing a message + tapping send walks through:
//   messageSending -> messageSent (with assistant reply persisted).

import 'package:cullinarium/features/ai_bot/data/models/chat_model.dart';
import 'package:cullinarium/features/ai_bot/data/models/message_model.dart';
import 'package:cullinarium/features/ai_bot/domain/repositories/chat_repository.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/delete_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/get_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/save_chat_use_case.dart';
import 'package:cullinarium/features/ai_bot/domain/usecases/send_message_use_case.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_cubit.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

class _FakeChatRepo implements ChatRepository {
  ChatModel? store;
```
