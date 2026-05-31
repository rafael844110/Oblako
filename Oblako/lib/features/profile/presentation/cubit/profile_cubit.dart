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
        loadProfile(authState.user!);
      } else {
        emit(const ProfileError("User not authenticated"));
      }
    });
  }

  void initialize() {
    final user = _authCubit.state.user;
    if (user != null) {
      loadProfile(user);
    } else {
      emit(const ProfileError("User not authenticated"));
    }
  }

  Future<void> loadProfile(dynamic user) async {
    emit(ProfileLoading());
    try {
      emit(ProfileLoaded(user, userType: user.role));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> fetchProfileFromBackend(String uid) async {
    emit(ProfileLoading());
    try {
      final user = await profileRepository.fetchProfile(uid);
      if (user != null) {
        emit(ProfileLoaded(user, userType: user.role));
      } else {
        emit(const ProfileError('Profile not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUserData(UserModel user) async {
    if (state is! ProfileLoaded) return;

    emit(ProfileLoading());

    try {
      final updatedUser = await profileRepository.updateUserData(
        userId: user.id,
        userData: user,
      );

      loadProfile(updatedUser);
      emit(
        ProfileLoaded(
          updatedUser,
          userType: 'user',
        ),
      );
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  // Type-specific update methods
  Future<void> updateChefProfile({
    required ChefModel chef,
  }) async {
    final updatedChef = await profileRepository.updateChefData(
      uid: chef.id,
      chefData: chef,
    );

    loadProfile(updatedChef);

    emit(ProfileLoaded(updatedChef, userType: 'chef'));
  }

  Future<void> updateAuthorProfile({
    required AuthorModel author,
  }) async {
    final updatedAuthor = await profileRepository.updateAuthorData(
      uid: author.id,
      authorData: author,
    );

    loadProfile(updatedAuthor);

    emit(ProfileLoaded(updatedAuthor, userType: 'author'));
  }

  Future<void> updateProfileImage({
    required File imageFile,
    required String userType,
  }) async {
    if (state is! ProfileLoaded) return;

    final currentUser = (state as ProfileLoaded).user;

    emit(ProfileLoaded(currentUser, userType: userType));

    try {
      final userId = currentUser.id;
      final imageUrl = await profileRepository.uploadProfileImage(
        imageFile: imageFile,
        userId: userId,
        userType: userType,
      );

      // Optionally refresh the profile with new image URL
      final updatedUser = _mergeImageUrl(currentUser, imageUrl, userType);
      emit(ProfileLoaded(updatedUser, userType: userType));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  dynamic _mergeImageUrl(dynamic user, String imageUrl, String type) {
    switch (type) {
      case 'user':
        return (user as UserModel).copyWith(avatar: imageUrl);
      case 'chef':
        return (user as ChefModel).copyWith(avatar: imageUrl);
      case 'author':
        return (user as AuthorModel).copyWith(avatar: imageUrl);
      default:
        throw Exception('Unknown user type');
    }
  }
}
