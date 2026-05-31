import 'package:cullinarium/features/chef/data/repositories/chef_repository_impl.dart';
import 'package:cullinarium/features/chef/domain/repositories/chef_repository.dart';
import 'package:cullinarium/features/chef/domain/usecases/get_all_chefs.dart';
import 'package:cullinarium/features/chef/presentation/cubit/chef_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:cullinarium/core/data/local/mock_database.dart';

void chefInjection() {
  final sl = GetIt.instance;

  // Cubit
  sl.registerFactory(() => ChefCubit(getAllChefs: sl()));

  // Use Cases
  sl.registerLazySingleton(() => GetAllChefs(sl()));

  // Repository
  sl.registerLazySingleton<ChefRepository>(
    () => ChefRepositoryImpl(sl<MockDatabase>()),
  );
}
