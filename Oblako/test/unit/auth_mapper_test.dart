import 'package:cullinarium/features/authentication/data/mappers/auth_mapper.dart';
import 'package:cullinarium/features/authentication/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const auth = AuthModel(
    id: 'u-1',
    name: 'Jane',
    email: 'jane@test.com',
    role: 'chef',
    phoneNumber: '+1234567890',
    createdAt: '2024-01-01T00:00:00Z',
  );

  group('AuthMapper', () {
    test('toJson includes every required field', () {
      final json = AuthMapper.toJson(auth);
      expect(json, {
        'id': 'u-1',
        'name': 'Jane',
        'email': 'jane@test.com',
        'role': 'chef',
        'phoneNumber': '+1234567890',
        'createdAt': '2024-01-01T00:00:00Z',
      });
    });

    test('fromJson reconstructs AuthModel', () {
      final json = AuthMapper.toJson(auth);
      final back = AuthMapper.fromJson(json);
      expect(back.id, auth.id);
      expect(back.email, auth.email);
      expect(back.role, auth.role);
    });

    test('fromJsonToChef projects to ChefModel preserving identity', () {
      final chef = AuthMapper.fromJsonToChef(auth);
      expect(chef.id, auth.id);
      expect(chef.name, auth.name);
      expect(chef.role, 'chef');
      expect(chef.profile, isNull);
      expect(chef.chefDetails, isNull);
    });

    test('fromJsonToUser projects to UserModel', () {
      final user = AuthMapper.fromJsonToUser(auth);
      expect(user.id, auth.id);
      expect(user.email, auth.email);
      expect(user.preferences, isNull);
    });

    test('fromJsonToAuthor projects to AuthorModel', () {
      final author = AuthMapper.fromJsonToAuthor(auth);
      expect(author.id, auth.id);
      expect(author.recipes, isNull);
      expect(author.courses, isNull);
    });

    test('toChef shape contains null profile + chefDetails', () {
      final m = AuthMapper.toChef(auth);
      expect(m['profile'], isNull);
      expect(m['chefDetails'], isNull);
      expect(m['id'], auth.id);
    });

    test('toUser shape contains null preferences', () {
      final m = AuthMapper.toUser(auth);
      expect(m['preferences'], isNull);
      expect(m['email'], auth.email);
    });

    test('toAuthor shape contains null courses + recipes', () {
      final m = AuthMapper.toAuthor(auth);
      expect(m['courses'], isNull);
      expect(m['recipes'], isNull);
    });
  });
}
