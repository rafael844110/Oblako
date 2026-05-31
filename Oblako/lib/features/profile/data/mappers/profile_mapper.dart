import 'package:cullinarium/features/profile/data/models/profile_model.dart';

class ProfileMapper {
  static Map<String, dynamic> toJson(ProfileModel profile) {
    return {
      'description': profile.description,
      'jobExperience': profile.jobExperience,
      'location': profile.location,
      'instagram': profile.instagram,
      'categories': profile.categories,
      'languages': profile.languages,
      'rating': profile.rating,
      'isApprovied': profile.isApprovied,
    };
  }

  static ProfileModel fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      description: json['description'],
      jobExperience: json['jobExperience'],
      location: json['location'],
      instagram: json['instagram'],
      categories: (json['categories'] as List<dynamic>?)?.cast<String>(),
      languages: (json['languages'] as List<dynamic>?)?.cast<String>(),
      rating: (json['rating'] as num?)?.toDouble(),
      isApprovied: json['isApprovied'] as bool?,
    );
  }
}
