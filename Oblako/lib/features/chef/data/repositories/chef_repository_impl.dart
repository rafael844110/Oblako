import 'package:cullinarium/core/data/local/mock_database.dart';
import 'package:cullinarium/features/chef/domain/repositories/chef_repository.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:dartz/dartz.dart';

class ChefRepositoryImpl implements ChefRepository {
  final MockDatabase _db;

  ChefRepositoryImpl(this._db);

  @override
  Future<Either<String, List<ChefModel>>> getAllChefs() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return Right(_db.chefs);
  }
}
