import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/features/profile/data/controllers/profile_data_controllers.dart';
import 'package:cullinarium/features/profile/presentation/widgets/details/tags_details.dart';
import 'package:cullinarium/features/profile/presentation/widgets/fields/profile_text_field.dart';
import 'package:flutter/material.dart';

class ProfileEditMode extends StatefulWidget {
  final String userType;
  final dynamic userData;
  final ProfileDataControllers controllers;
  final VoidCallback onSave;
  final Function(bool) onChanged;

  const ProfileEditMode({
    super.key,
    required this.userType,
    required this.userData,
    required this.controllers,
    required this.onSave,
    required this.onChanged,
  });

  @override
  State<ProfileEditMode> createState() => _ProfileEditModeState();
}

class _ProfileEditModeState extends State<ProfileEditMode> {
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    // Add change listeners but don't re-initialize controllers here
    // as they should already be initialized in the parent widget
    _setupChangeListeners();
  }

  void _setupChangeListeners() {
    // Remove existing listeners first to avoid duplicates
    widget.controllers.removeAllListeners();

    // Add the change listener
    widget.controllers.addChangeListener(_handleChanges);
  }

  void _handleChanges() {
    if (!mounted) return;
    setState(() {
      _hasChanges = true;
    });
    widget.onChanged(true);
  }

  // Also handle manual text changes directly in the text fields
  void _handleTextChange(String _) {
    if (!_hasChanges) {
      setState(() {
        _hasChanges = true;
      });
      widget.onChanged(true);
    }
  }

  @override
  void dispose() {
    // Only remove our specific change listener
    widget.controllers.removeChangeListener(_handleChanges);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ..._buildEditForm(),
          const SizedBox(height: 20),
          AppButton(
            title: 'Save Changes',
            width: size.width,
            onPressed: widget.onSave,
            isDisabled: !_hasChanges,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildEditForm() {
    // Basic form fields for all user types
    List<Widget> formFields = [
      _buildSectionTitle('About You'),
      ProfileTextField(
        label: 'Description',
        hintText: 'Tell us about yourself',
        controller: widget.controllers.descriptionController,
        maxLines: 3,
        onChanged: _handleTextChange,
      ),

      const SizedBox(height: 24),
      _buildSectionTitle('Professional Info'),
      ProfileTextField(
        label: 'Experience (years)',
        controller: widget.controllers.experienceController,
        keyboardType: TextInputType.number,
        onChanged: _handleTextChange,
      ),
      const SizedBox(height: 16),
      ProfileTextField(
        label: 'Location',
        controller: widget.controllers.locationController,
        onChanged: _handleTextChange,
      ),
      const SizedBox(height: 16),
      TagsDetails(
        data: widget.controllers.selectedCategories,
        title: 'Specialties',
        onTagSelected: (tags) {
          setState(() {
            widget.controllers.selectedCategories = tags;
            _hasChanges = true;
            widget.onChanged(true);
          });
        },
      ),
      const SizedBox(height: 16),
      TagsDetails(
        data: widget.controllers.selectedLanguages,
        title: 'Languages',
        onTagSelected: (tags) {
          setState(() {
            widget.controllers.selectedLanguages = tags;
            _hasChanges = true;
            widget.onChanged(true);
          });
        },
      ),

      // Common contact fields for all professional users
      const SizedBox(height: 24),
      _buildSectionTitle('Contact Details'),
      ProfileTextField(
        label: 'WhatsApp',
        controller: widget.controllers.whatsappController,
        hintText: 'WhatsApp number',
        keyboardType: TextInputType.phone,
        onChanged: _handleTextChange,
      ),
      const SizedBox(height: 16),
      ProfileTextField(
        label: 'Instagram',
        controller: widget.controllers.instagramController,
        hintText: 'Instagram username',
        onChanged: _handleTextChange,
      ),
    ];

    return formFields;
  }

  Widget _buildSectionTitle(String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
