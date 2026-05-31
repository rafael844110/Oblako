import 'package:cullinarium/features/profile/data/models/profile_model.dart';

class AuthorModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String? avatar;
  final String? createdAt;
  final ProfileModel? profile;
  final List<String>? courses;
  final List<String>? recipes;

  const AuthorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    this.avatar,
    this.createdAt,
    this.profile,
    this.courses,
    this.recipes,
  });

  AuthorModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phoneNumber,
    String? avatar,
    String? createdAt,
    ProfileModel? profile,
    List<String>? courses,
    List<String>? recipes,
  }) {
    return AuthorModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      profile: profile ?? this.profile,
      courses: courses ?? this.courses,
      recipes: recipes ?? this.recipes,
    );
  }
}
