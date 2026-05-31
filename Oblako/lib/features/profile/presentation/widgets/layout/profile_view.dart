import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/core/widgets/cards/avatar_card.dart';
import 'package:cullinarium/core/widgets/utils/app_tag.dart';
import 'package:cullinarium/core/utils/dummy_data_seeder.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/widgets/layout/profile_content.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key, required this.state});

  final ProfileLoaded state;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildProfileHeader(context, state),
        SliverToBoxAdapter(
          child: ProfileContent(state: state),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(BuildContext context, ProfileLoaded state) {
    final theme = Theme.of(context);
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: const Icon(Icons.cloud_upload_outlined, color: Colors.white),
          tooltip: 'Seed Dummy Data',
          onPressed: () async {
            final scaffoldMessenger = ScaffoldMessenger.of(context);
            try {
              // Ensure immediate feedback
              scaffoldMessenger.showSnackBar(
                const SnackBar(content: Text('Seeding data...')),
              );

              await DummyDataSeeder().seedChefs();
              await DummyDataSeeder().seedRecipes();
              await DummyDataSeeder().seedUsers();

              scaffoldMessenger.showSnackBar(
                const SnackBar(
                    content: Text('Dummy data seeded successfully!'),
                    backgroundColor: Colors.green),
              );
            } catch (e) {
              scaffoldMessenger.showSnackBar(
                SnackBar(
                    content: Text('Error seeding data: $e'),
                    backgroundColor: Colors.red),
              );
            }
          },
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.shade700,
                  ],
                ),
              ),
            ),
            // Profile image and name
            Positioned(
              top: kToolbarHeight * 1.5,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  const AvatarCard(),
                  const SizedBox(height: 12),
                  Text(
                    state.user.name,
                    style: theme.textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  AppTag(label: state.userType),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
