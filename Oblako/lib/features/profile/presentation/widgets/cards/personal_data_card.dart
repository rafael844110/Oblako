import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/pages/personal_details_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalDataCard extends StatelessWidget {
  const PersonalDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Data',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProfileError) {
                  return Center(
                    child: Text(
                      'Error loading data: ${state.message}',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  );
                } else if (state is ProfileLoaded) {
                  final user = state.user;
                  return Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.email,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.phoneNumber,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalDetailsEditPage(),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.shade100,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.person,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
