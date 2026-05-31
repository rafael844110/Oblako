import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChefRepository {
  Future<Either<String, List<ChefModel>>> getAllChefs();
}
