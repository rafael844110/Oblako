import 'package:cullinarium/features/profile/data/controllers/profile_data_controllers.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProfileDataControllers c;

  setUp(() {
    c = ProfileDataControllers();
  });

  tearDown(() {
    c.dispose();
  });

  test('initializeFromProfile pulls fields off ChefModel.profile', () {
    final chef = ChefModel(
      id: 'c-1',
      name: 'Jane',
      email: 'j@e.com',
      role: 'chef',
      phoneNumber: '+10',
      profile: const ProfileModel(
        description: 'desc',
        jobExperience: 4,
        location: 'NY',
        instagram: '@jane',
        categories: ['italian'],
        languages: ['en'],
      ),
    );

    c.initializeFromProfile(chef);

    expect(c.nameController.text, 'Jane');
    expect(c.descriptionController.text, 'desc');
    expect(c.experienceController.text, '4');
    expect(c.locationController.text, 'NY');
    expect(c.instagramController.text, '@jane');
    expect(c.whatsappController.text, '+10');
    expect(c.selectedCategories, ['italian']);
    expect(c.selectedLanguages, ['en']);
  });

  test('createUpdatedChef writes controller values back', () {
    final chef = ChefModel(
      id: 'c-1',
      name: 'Jane',
      email: 'j@e.com',
      role: 'chef',
      phoneNumber: '+10',
    );

    c.descriptionController.text = 'updated';
    c.experienceController.text = '7';
    c.locationController.text = 'Paris';
    c.instagramController.text = '@new';
    c.whatsappController.text = '+11';
    c.selectedCategories = ['french'];
    c.selectedLanguages = ['fr'];

    final updated = c.createUpdatedChef(chef);

    expect(updated.phoneNumber, '+11');
    expect(updated.profile?.description, 'updated');
    expect(updated.profile?.jobExperience, 7);
    expect(updated.profile?.location, 'Paris');
    expect(updated.profile?.categories, ['french']);
  });

  test('experience field defaults to 0 when not a valid int', () {
    final chef = ChefModel(
      id: 'c-1',
      name: 'Jane',
      email: 'j@e.com',
      role: 'chef',
      phoneNumber: '+10',
    );
    c.experienceController.text = 'abc';
    final updated = c.createUpdatedChef(chef);
    expect(updated.profile?.jobExperience, 0);
  });

  test('addChangeListener fires when a controller text changes', () {
    var changes = 0;
    c.addChangeListener(() => changes++);
    c.nameController.text = 'first';
    c.descriptionController.text = 'd';
    expect(changes, 2);
  });

  test('removeAllListeners detaches every listener', () {
    var changes = 0;
    c.addChangeListener(() => changes++);
    c.removeAllListeners();
    c.nameController.text = 'noop';
    expect(changes, 0);
  });

  test('resetControllers clears all fields + selections', () {
    c.nameController.text = 'x';
    c.selectedCategories = ['a'];
    c.resetControllers();
    expect(c.nameController.text, '');
    expect(c.selectedCategories, isEmpty);
  });
}
