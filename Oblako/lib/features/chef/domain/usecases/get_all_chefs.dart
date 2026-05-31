import 'package:cullinarium/features/chef/domain/repositories/chef_repository.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:dartz/dartz.dart';

class GetAllChefs {
  final ChefRepository _chefRepository;

  GetAllChefs(this._chefRepository);

  Future<Either<String, List<ChefModel>>> call() async {
    return await _chefRepository.getAllChefs();
  }
}
