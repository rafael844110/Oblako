import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/mappers/profile_mapper.dart';

class AuthorMapper {
  static Map<String, dynamic> toJson(AuthorModel author) {
    return {
      'id': author.id,
      'name': author.name,
      'email': author.email,
      'role': author.role,
      'phoneNumber': author.phoneNumber,
      'avatar': author.avatar,
      'createdAt': author.createdAt,
      'profile':
          author.profile != null ? ProfileMapper.toJson(author.profile!) : null,
      'courses': author.courses,
      'recipes': author.recipes,
    };
  }

  static AuthorModel fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      phoneNumber: json['phoneNumber'],
      avatar: json['avatar'],
      createdAt: json['createdAt'],
      profile: json['profile'] != null
          ? ProfileMapper.fromJson(json['profile'])
          : null,
      courses:
          json['courses'] != null ? List<String>.from(json['courses']) : null,
      recipes:
          json['recipes'] != null ? List<String>.from(json['recipes']) : null,
    );
  }
}
