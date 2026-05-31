import 'package:cullinarium/features/profile/data/models/user_model.dart';

class UserMapper {
  static Map<String, dynamic> toJson(UserModel user) {
    return {
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'role': user.role,
      'phoneNumber': user.phoneNumber,
      'avatar': user.avatar,
      'createdAt': user.createdAt,
      'preferences': user.preferences,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
      createdAt: json['createdAt'],
      phoneNumber: json['phoneNumber'],
      avatar: json['avatar'],
      preferences: json['preferences'] != null
          ? (json['preferences'] as List<dynamic>).cast<String>()
          : null,
    );
  }
}
