// _userModel_profile_form.dart
import 'package:cullinarium/features/profile/data/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProfileForm extends StatefulWidget {
  final UserModel user;
  final Function(UserModel) onSave;

  const UserProfileForm({
    super.key,
    required this.user,
    required this.onSave,
  });

  @override
  State<UserProfileForm> createState() => _UserProfileFormState();
}

class _UserProfileFormState extends State<UserProfileForm> {
  late TextEditingController _specialtyController;
  late TextEditingController _experienceController;
  late List<String> _selectedCuisines;

  @override
  void initState() {
    super.initState();
    _specialtyController = TextEditingController(
      text: widget.user.name,
    );
    _experienceController = TextEditingController(
      text: widget.user.role,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'User Profile',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _specialtyController,
          decoration: InputDecoration(
            labelText: 'Specialty',
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 15),
        TextField(
          controller: _experienceController,
          decoration: InputDecoration(
            labelText: 'Experience',
            border: const OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 15),
        // Cuisine selection widget would go here
        // This would be a custom widget for multi-select
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _saveProfile,
          child: const Text('Save Profile'),
        ),
      ],
    );
  }

  void _saveProfile() {}

  @override
  void dispose() {
    _specialtyController.dispose();
    _experienceController.dispose();
    super.dispose();
  }
}
