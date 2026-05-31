import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/pages/my_profile_page.dart';
import 'package:cullinarium/features/profile/presentation/pages/settings_page.dart';
import 'package:cullinarium/features/profile/presentation/widgets/buttons/logout_button.dart';
import 'package:cullinarium/features/profile/presentation/widgets/cards/personal_data_card.dart';
import 'package:cullinarium/features/profile/presentation/widgets/cards/profile_card.dart';
import 'package:cullinarium/features/profile/presentation/widgets/forms/chef_profile_form.dart';
import 'package:flutter/material.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({super.key, required this.state});

  final ProfileLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contact info section
          const PersonalDataCard(),
          const SizedBox(height: 24),

          // Profile section
          if (state.userType == 'chef' || state.userType == 'author') ...[
            _buildSectionHeader(context, 'Profile'),
            const SizedBox(height: 8),
            ProfileCard(
              icon: Icons.restaurant,
              title: 'My Profile',
              subtitle: 'Manage your profile and personal information',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyProfilePage(),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],

          // Role-specific sections
          if (state.userType == 'chef') ...[
            _buildSectionHeader(context, 'Professional Information'),
            const SizedBox(height: 8),
            ProfileCard(
              icon: Icons.restaurant,
              title: 'Culinary Skills',
              subtitle:
                  'Manage your specializations and culinary styles',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChefProfileForm(
                      initialData: state.user.chefDetails,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
          ],

          // Settings section
          _buildSectionHeader(context, 'Settings'),
          const SizedBox(height: 8),
          ProfileCard(
            icon: Icons.settings,
            title: 'App Settings',
            subtitle: 'Language, notifications and preferences',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const SettingsPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          ProfileCard(
            icon: Icons.shield,
            title: 'Privacy',
            subtitle: 'Manage your data and privacy',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          ProfileCard(
            icon: Icons.help_outline,
            title: 'Help & Support',
            subtitle: 'FAQs and contact information',
            onTap: () {},
          ),
          const SizedBox(height: 32),

          // Logout button
          const LogoutButton(),
          const SizedBox(height: kToolbarHeight),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
      ),
    );
  }
}
