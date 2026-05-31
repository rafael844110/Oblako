class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String createdAt;
  final String phoneNumber;
  final String? avatar;
  final List<String>? preferences;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.phoneNumber,
    this.avatar,
    this.preferences,
  });

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? createdAt,
    String? phoneNumber,
    String? avatar,
    List<String>? preferences,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      preferences: preferences ?? this.preferences,
    );
  }
}
