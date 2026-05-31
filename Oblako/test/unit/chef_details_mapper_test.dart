import 'package:cullinarium/features/profile/data/mappers/chef_details_mapper.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_details_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChefDetailsMapper', () {
    const details = ChefDetailsModel(
      kitchen: 'Italian',
      extraKitchen: 'French',
      guestsCapability: 20,
      workSchedule: 'evenings',
      menu: ['pasta', 'tiramisu'],
      pricePerPerson: 49.99,
      canGoToRegions: true,
      images: ['a.jpg', 'b.jpg'],
    );

    test('toJson <-> fromJson roundtrip', () {
      final json = ChefDetailsMapper.toJson(details);
      final back = ChefDetailsMapper.fromJson(json);
      expect(back.kitchen, details.kitchen);
      expect(back.guestsCapability, 20);
      expect(back.pricePerPerson, 49.99);
      expect(back.menu, details.menu);
      expect(back.images, details.images);
      expect(back.canGoToRegions, true);
    });

    test('fromJson coerces int pricePerPerson to double', () {
      final json = ChefDetailsMapper.toJson(details);
      json['pricePerPerson'] = 50;
      final back = ChefDetailsMapper.fromJson(json);
      expect(back.pricePerPerson, 50.0);
    });

    test('fromJson allows null canGoToRegions', () {
      final json = ChefDetailsMapper.toJson(details);
      json['canGoToRegions'] = null;
      final back = ChefDetailsMapper.fromJson(json);
      expect(back.canGoToRegions, isNull);
    });
  });
}
