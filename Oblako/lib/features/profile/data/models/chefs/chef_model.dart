import 'package:cullinarium/features/profile/data/models/chefs/chef_details_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';

class ChefModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String phoneNumber;
  final String? avatar;
  final String? createdAt;
  final ProfileModel? profile;
  final ChefDetailsModel? chefDetails;

  const ChefModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.phoneNumber,
    this.avatar,
    this.createdAt,
    this.profile,
    this.chefDetails,
  });

  ChefModel copyWith({
    String? id,
    String? name,
    String? email,
    String? role,
    String? phoneNumber,
    String? avatar,
    String? createdAt,
    ProfileModel? profile,
    ChefDetailsModel? chefDetails,
  }) {
    return ChefModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
      profile: profile ?? this.profile,
      chefDetails: chefDetails ?? this.chefDetails,
    );
  }
}
