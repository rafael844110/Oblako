import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/mappers/profile_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/chef_details_mapper.dart';

class ChefMapper {
  static Map<String, dynamic> toJson(ChefModel chef) {
    return {
      'id': chef.id,
      'name': chef.name,
      'email': chef.email,
      'role': chef.role,
      'phoneNumber': chef.phoneNumber,
      'avatar': chef.avatar,
      'createdAt': chef.createdAt,
      'profile':
          chef.profile != null ? ProfileMapper.toJson(chef.profile!) : null,
      'chefDetails': chef.chefDetails != null
          ? ChefDetailsMapper.toJson(chef.chefDetails!)
          : null,
    };
  }

  static ChefModel fromJson(Map<String, dynamic> json) {
    return ChefModel(
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
      chefDetails: json['chefDetails'] != null
          ? ChefDetailsMapper.fromJson(json['chefDetails'])
          : null,
    );
  }
}
