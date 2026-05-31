import 'package:cullinarium/features/profile/data/models/chefs/chef_details_model.dart';

class ChefDetailsMapper {
  static Map<String, dynamic> toJson(ChefDetailsModel chefDetails) {
    return {
      'kitchen': chefDetails.kitchen,
      'extraKitchen': chefDetails.extraKitchen,
      'guestsCapability': chefDetails.guestsCapability,
      'workSchedule': chefDetails.workSchedule,
      'menu': chefDetails.menu,
      'pricePerPerson': chefDetails.pricePerPerson,
      'canGoToRegions': chefDetails.canGoToRegions,
      'images': chefDetails.images,
    };
  }

  static ChefDetailsModel fromJson(Map<String, dynamic> json) {
    return ChefDetailsModel(
      kitchen: json['kitchen'],
      extraKitchen: json['extraKitchen'],
      guestsCapability: json['guestsCapability'],
      workSchedule: json['workSchedule'],
      menu: (json['menu'] as List<dynamic>).cast<String>(),
      pricePerPerson: (json['pricePerPerson'] as num).toDouble(),
      canGoToRegions: json['canGoToRegions'] as bool?,
      images: (json['images'] as List<dynamic>).cast<String>(),
    );
  }
}
