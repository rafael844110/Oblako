class ProfileModel {
  final String description;
  final int jobExperience;
  final String location;
  final String? instagram;
  final List<String>? categories;
  final List<String>? languages;
  final double? rating;
  final bool? isApprovied;

  const ProfileModel({
    required this.description,
    required this.jobExperience,
    required this.location,
    this.instagram,
    this.categories,
    this.languages,
    this.rating,
    this.isApprovied,
  });

  ProfileModel copyWith({
    String? description,
    int? jobExperience,
    String? location,
    String? profilePicture,
    String? instagram,
    List<String>? categories,
    List<String>? languages,
    double? rating,
    bool? isApprovied,
  }) {
    return ProfileModel(
      description: description ?? this.description,
      jobExperience: jobExperience ?? this.jobExperience,
      location: location ?? this.location,
      instagram: instagram ?? this.instagram,
      categories: categories ?? this.categories,
      languages: languages ?? this.languages,
      rating: rating ?? this.rating,
      isApprovied: isApprovied ?? this.isApprovied,
    );
  }
}
