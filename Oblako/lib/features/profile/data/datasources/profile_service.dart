import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/core/data/local/mock_database.dart';
import 'package:cullinarium/features/profile/data/mappers/author_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';

class ProfileService {
  final MockDatabase _db;
  final FirebaseFirestore _firestore;

  ProfileService(this._db, this._firestore);

  Future<dynamic> fetchProfile(String uid) async {
    final chefDoc = await _firestore.collection('chefs').doc(uid).get();
    if (chefDoc.exists) {
      final data = chefDoc.data()!;
      data['id'] = uid;
      return ChefMapper.fromJson(data);
    }

    final userDoc = await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      final data = userDoc.data()!;
      data['id'] = uid;
      return UserMapper.fromJson(data);
    }

    return null;
  }

  // User data
  Future<dynamic> updateUserData({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _db.users.indexWhere((u) => u.id == userId);
    if (index != -1) {
      final updatedUser = UserMapper.fromJson(data);
      _db.users[index] = updatedUser;
    }
  }

  // Update Chef data
  Future<void> updateChefData(String uid, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final images = data['images'] as List<dynamic>?;
    if (images != null) {
      final newImages = <String>[];
      for (final image in images) {
        if (image is String) {
          newImages.add(image);
        }
      }
      data['images'] = newImages;
    }

    final index = _db.chefs.indexWhere((c) => c.id == uid);
    if (index != -1) {
      final updatedChef = ChefMapper.fromJson(data);
      _db.chefs[index] = updatedChef;
    }
  }

  /// Update author data
  Future<void> updateAuthorData(String uid, Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _db.authors.indexWhere((a) => a.id == uid);
    if (index != -1) {
      final updatedAuthor = AuthorMapper.fromJson(data);
      _db.authors[index] = updatedAuthor;
    }
  }

  // Update user profile image
  Future<String> uploadProfileImage({
    required File imageFile,
    required String userId,
    required String userType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // Return the local file path as the "URL"
    final mockUrl = imageFile.path;

    // Update the user's avatar in DB
    await updateProfileImageUrl(
        userId: userId, imageUrl: mockUrl, userType: userType);

    return mockUrl;
  }

  // Add uploaded image URL to MockDatabase
  Future<void> updateProfileImageUrl({
    required String userId,
    required String imageUrl,
    required String userType,
  }) async {
    if (userType == 'chef') {
      final index = _db.chefs.indexWhere((u) => u.id == userId);
      if (index != -1) {
        final chef = _db.chefs[index];
        final json = ChefMapper.toJson(chef);
        json['avatar'] = imageUrl;
        _db.chefs[index] = ChefMapper.fromJson(json);
      }
    } else if (userType == 'author') {
      final index = _db.authors.indexWhere((u) => u.id == userId);
      if (index != -1) {
        final json = AuthorMapper.toJson(_db.authors[index]);
        json['avatar'] = imageUrl;
        _db.authors[index] = AuthorMapper.fromJson(json);
      }
    } else {
      // User
      final index = _db.users.indexWhere((u) => u.id == userId);
      if (index != -1) {
        final json = UserMapper.toJson(_db.users[index]);
        json['avatar'] = imageUrl;
        _db.users[index] = UserMapper.fromJson(json);
      }
    }

    // Also update currentUser if it matches
    if (_db.currentUser != null && _db.currentUser?.id == userId) {
      if (userType == 'chef') {
        try {
          _db.currentUser = _db.chefs.firstWhere((c) => c.id == userId);
        } catch (_) {}
      } else if (userType == 'author') {
        try {
          _db.currentUser = _db.authors.firstWhere((a) => a.id == userId);
        } catch (_) {}
      } else {
        try {
          _db.currentUser = _db.users.firstWhere((u) => u.id == userId);
        } catch (_) {}
      }
    }
  }

  Future<void> addDummyData() async {
    // No-op or call DB seed
  }
}
