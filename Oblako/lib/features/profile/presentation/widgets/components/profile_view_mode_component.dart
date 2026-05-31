import 'package:cullinarium/features/profile/data/controllers/profile_data_controllers.dart';
import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/presentation/widgets/cards/count_card.dart';
import 'package:cullinarium/features/profile/presentation/widgets/details/contanct_details.dart';
import 'package:cullinarium/features/profile/presentation/widgets/details/row_view_details.dart';
import 'package:cullinarium/features/profile/presentation/widgets/details/tags_details.dart';
import 'package:flutter/material.dart';

class ProfileViewMode extends StatefulWidget {
  final String userType;
  final dynamic userData;
  final ProfileDataControllers controllers;

  const ProfileViewMode({
    super.key,
    required this.userType,
    required this.userData,
    required this.controllers,
  });

  @override
  State<ProfileViewMode> createState() => _ProfileViewModeState();
}

class _ProfileViewModeState extends State<ProfileViewMode> {
  @override
  void initState() {
    widget.controllers.initializeFromProfile(widget.userData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildProfileDetails(context),
      ),
    );
  }

  List<Widget> _buildProfileDetails(BuildContext context) {
    final isPro = widget.userType == 'chef' || widget.userType == 'author';

    final List<Widget> sections = [
      _buildDescriptionSection(context),
    ];

    if (isPro) {
      sections.addAll([
        const SizedBox(height: 24),
        _buildProfessionalInfoSection(context),
        const SizedBox(height: 24),
        _buildContactSection(context),
      ]);
    }

    if (widget.userType == 'chef') {
      sections.addAll([
        const SizedBox(height: 24),
        _buildRecipeAndCourseCount(widget.userData),
      ]);
    } else if (widget.userType == 'author') {
      sections.addAll([
        const SizedBox(height: 24),
        _buildAuthorStats(widget.userData),
      ]);
    }

    return sections;
  }

  Widget _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
            context, 'Description'),
        Text(
          widget.controllers.descriptionController.text.isEmpty
              ? 'No description yet'
              : widget.controllers.descriptionController.text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildProfessionalInfoSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Professional Information'),
        RowViewDetails(
          title: 'Experience',
          value: '${widget.controllers.experienceController.text} years',
        ),
        RowViewDetails(
          title: 'Location',
          value: widget.controllers.locationController.text.isEmpty
              ? 'Not specified'
              : widget.controllers.locationController.text,
        ),
        const SizedBox(height: 16),
        TagsDetails(
          data: widget.controllers.selectedCategories,
          title: 'Specialties',
          isViewMode: true,
        ),
        const SizedBox(height: 16),
        TagsDetails(
          data: widget.controllers.selectedLanguages,
          title: 'Languages',
          isViewMode: true,
        ),
      ],
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Contact'),
        ContanctDetails(
          whatsapp: widget.controllers.whatsappController.text,
          instagram: widget.controllers.instagramController.text,
        ),
      ],
    );
  }

  Widget _buildRecipeAndCourseCount(ChefModel chef) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        CountCard(icon: Icons.restaurant_menu, count: 0, label: 'Recipes'),
        CountCard(icon: Icons.school, count: 0, label: 'Courses'),
      ],
    );
  }

  Widget _buildAuthorStats(AuthorModel author) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        CountCard(icon: Icons.book, count: 0, label: 'Publications'),
        CountCard(icon: Icons.people, count: 0, label: 'Followers'),
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
