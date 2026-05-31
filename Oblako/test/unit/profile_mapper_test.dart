import 'package:cullinarium/features/profile/data/mappers/chef_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/profile_mapper.dart';
import 'package:cullinarium/features/profile/data/mappers/user_mapper.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileMapper', () {
    const profile = ProfileModel(
      description: 'Senior pastry chef',
      jobExperience: 5,
      location: 'Paris',
      instagram: '@chefjane',
      categories: ['pastry', 'french'],
      languages: ['en', 'fr'],
      rating: 4.7,
      isApprovied: true,
    );

    test('toJson serializes all fields', () {
      final json = ProfileMapper.toJson(profile);
      expect(json['description'], 'Senior pastry chef');
      expect(json['jobExperience'], 5);
      expect(json['categories'], ['pastry', 'french']);
      expect(json['rating'], 4.7);
      expect(json['isApprovied'], true);
    });

    test('fromJson handles int rating', () {
      final json = ProfileMapper.toJson(profile);
      json['rating'] = 5;
      final p = ProfileMapper.fromJson(json);
      expect(p.rating, 5.0);
    });

    test('fromJson tolerates null optional collections', () {
      final p = ProfileMapper.fromJson({
        'description': 'd',
        'jobExperience': 1,
        'location': 'loc',
        'instagram': null,
        'categories': null,
        'languages': null,
        'rating': null,
        'isApprovied': null,
      });
      expect(p.categories, isNull);
      expect(p.languages, isNull);
      expect(p.rating, isNull);
    });

    test('copyWith preserves untouched fields', () {
      final p = profile.copyWith(rating: 3.0);
      expect(p.rating, 3.0);
      expect(p.description, profile.description);
      expect(p.location, profile.location);
    });
  });

  group('UserMapper', () {
    const user = UserModel(
      id: 'u-1',
      name: 'Jane',
      email: 'jane@test.com',
      role: 'user',
      createdAt: '2024-01-01',
      phoneNumber: '+1',
      preferences: ['vegan', 'gluten-free'],
    );

    test('toJson <-> fromJson roundtrip', () {
      final json = UserMapper.toJson(user);
      final u = UserMapper.fromJson(json);
      expect(u.id, user.id);
      expect(u.preferences, ['vegan', 'gluten-free']);
    });

    test('fromJson handles null preferences', () {
      final json = UserMapper.toJson(user);
      json['preferences'] = null;
      final u = UserMapper.fromJson(json);
      expect(u.preferences, isNull);
    });
  });

  group('ChefMapper', () {
    const chef = ChefModel(
      id: 'c-1',
      name: 'Pierre',
      email: 'p@test.com',
      role: 'chef',
      phoneNumber: '+1',
      profile: ProfileModel(
        description: 'd',
        jobExperience: 2,
        location: 'NY',
      ),
    );

    test('toJson nests profile', () {
      final json = ChefMapper.toJson(chef);
      expect(json['profile'], isNotNull);
      expect(json['profile']['description'], 'd');
      expect(json['chefDetails'], isNull);
    });

    test('fromJson reconstructs nested profile', () {
      final json = ChefMapper.toJson(chef);
      final back = ChefMapper.fromJson(json);
      expect(back.id, 'c-1');
      expect(back.profile?.location, 'NY');
    });
  });
}
