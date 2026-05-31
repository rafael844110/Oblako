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

  // sl<SharedPreferences>().clear();

  // Register Mock Database
  sl.registerLazySingleton<MockDatabase>(() => MockDatabase());

  await authInjection();

  profileInjection();

  chefInjection();

  recipeInjection();
}
