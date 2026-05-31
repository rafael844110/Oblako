import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';

/// Shared controllers for maintaining state between view and edit modes
class ProfileDataControllers {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();

  List<String> selectedCategories = [];
  List<String> selectedLanguages = [];

  // Track all attached listeners for proper cleanup
  final List<VoidCallback> _changeListeners = [];

  /// Initialize all controllers from profile data
  void initializeFromProfile(dynamic profileData) {
    if (profileData is ChefModel) {
      nameController.text = profileData.name;
      descriptionController.text = profileData.profile?.description ?? '';
      experienceController.text =
          profileData.profile?.jobExperience.toString() ?? '0';
      locationController.text = profileData.profile?.location ?? '';
      instagramController.text = profileData.profile?.instagram ?? '';
      whatsappController.text = profileData.phoneNumber;

      selectedCategories =
          List<String>.from(profileData.profile?.categories ?? []);
      selectedLanguages =
          List<String>.from(profileData.profile?.languages ?? []);
    } else if (profileData is AuthorModel) {
      nameController.text = profileData.name;
      descriptionController.text = profileData.profile?.description ?? '';
      instagramController.text = profileData.profile?.instagram ?? '';
      whatsappController.text = profileData.phoneNumber;

      selectedCategories =
          List<String>.from(profileData.profile?.categories ?? []);
      selectedLanguages =
          List<String>.from(profileData.profile?.languages ?? []);
    }
  }

  /// Create an updated Chef model from the current controller values
  ChefModel createUpdatedChef(ChefModel originalChef) {
    return originalChef.copyWith(
      phoneNumber: whatsappController.text,
      profile: ProfileModel(
        description: descriptionController.text,
        jobExperience: int.tryParse(experienceController.text) ?? 0,
        location: locationController.text,
        instagram: instagramController.text,
        categories: selectedCategories,
        languages: selectedLanguages,
      ),
    );
  }

  /// Create an updated Author model from the current controller values
  AuthorModel createUpdatedAuthor(AuthorModel originalAuthor) {
    return originalAuthor.copyWith(
      phoneNumber: whatsappController.text,
      profile: ProfileModel(
        description: descriptionController.text,
        instagram: instagramController.text,
        languages: selectedLanguages,
        categories: selectedCategories,
        jobExperience: experienceController.text.isNotEmpty
            ? int.tryParse(experienceController.text) ?? 0
            : 0,
        location: locationController.text,
      ),
    );
  }

  /// Add a change listener to all controllers
  void addChangeListener(VoidCallback onChange) {
    // Add to our list for tracking
    _changeListeners.add(onChange);

    // Add to each controller
    nameController.addListener(onChange);
    descriptionController.addListener(onChange);
    experienceController.addListener(onChange);
    locationController.addListener(onChange);
    instagramController.addListener(onChange);
    whatsappController.addListener(onChange);
  }

  /// Remove a specific change listener from all controllers
  void removeChangeListener(VoidCallback onChange) {
    // Remove from our list
    _changeListeners.remove(onChange);

    // Remove from each controller
    nameController.removeListener(onChange);
    descriptionController.removeListener(onChange);
    experienceController.removeListener(onChange);
    locationController.removeListener(onChange);
    instagramController.removeListener(onChange);
    whatsappController.removeListener(onChange);
  }

  /// Remove all change listeners
  void removeAllListeners() {
    for (final listener in List.from(_changeListeners)) {
      removeChangeListener(listener);
    }
    _changeListeners.clear();
  }

  /// Reset all controllers to empty
  void resetControllers() {
    nameController.clear();
    descriptionController.clear();
    experienceController.clear();
    locationController.clear();
    instagramController.clear();
    whatsappController.clear();
    selectedCategories = [];
    selectedLanguages = [];
  }

  /// Dispose all controllers
  void dispose() {
    removeAllListeners();

    nameController.dispose();
    descriptionController.dispose();
    experienceController.dispose();
    locationController.dispose();
    instagramController.dispose();
    whatsappController.dispose();
  }
}
