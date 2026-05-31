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
