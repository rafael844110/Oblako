part of 'chef_cubit.dart';

abstract class ChefState extends Equatable {
  const ChefState();

  @override
  List<Object> get props => [];
}

class ChefInitial extends ChefState {}

class ChefLoading extends ChefState {}

class ChefLoaded extends ChefState {
  final List<ChefModel> chefs;

  const ChefLoaded(this.chefs);

  @override
  List<Object> get props => [chefs];
}

class ChefError extends ChefState {
  final String message;

  const ChefError(this.message);

  @override
  List<Object> get props => [message];
}
