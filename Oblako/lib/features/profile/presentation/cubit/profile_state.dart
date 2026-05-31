part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final dynamic user;
  final String userType;

  const ProfileLoaded(
    this.user, {
    this.userType = 'user',
  });

  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileImagePicked extends ProfileState {
  final File? imageFile;

  const ProfileImagePicked(this.imageFile);

  @override
  List<Object> get props => [imageFile!];
}

class ProfileImageUploading extends ProfileState {}

class ProfileImageUploaded extends ProfileState {
  final String imageUrl;

  const ProfileImageUploaded(this.imageUrl);

  @override
  List<Object> get props => [imageUrl];
}

class ProfileImageUploadError extends ProfileState {
  final String message;

  const ProfileImageUploadError(this.message);

  @override
  List<Object> get props => [message];
}
