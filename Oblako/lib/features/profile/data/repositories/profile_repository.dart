import 'dart:io';

import 'package:cullinarium/features/profile/data/datasources/profile_service.dart';
import 'package:cullinarium/features/profile/data/mappers/author_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';
import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';

class ProfileRepository {
  final ProfileService _profileService;

  ProfileRepository(this._profileService);

  Future<UserModel> updateUserData({
    required String userId,
    required UserModel userData,
  }) async {
    await _profileService.updateUserData(
        userId: userId, data: UserMapper.toJson(userData));
    return userData;
  }

  Future<ChefModel> updateChefData({
    required String uid,
    required ChefModel chefData,
  }) async {
    await _profileService.updateChefData(uid, ChefMapper.toJson(chefData));
    return chefData;
  }

  Future<AuthorModel> updateAuthorData({
    required String uid,
    required AuthorModel authorData,
  }) async {
    await _profileService.updateAuthorData(
        uid, AuthorMapper.toJson(authorData));
    return authorData;
  }

  Future<dynamic> fetchProfile(String uid) async {
    return await _profileService.fetchProfile(uid);
  }

  Future<String> uploadProfileImage({
    required File imageFile,
    required String userId,
    required String userType,
  }) async {
    return await _profileService.uploadProfileImage(
      imageFile: imageFile,
      userId: userId,
      userType: userType,
    );
  }
}
