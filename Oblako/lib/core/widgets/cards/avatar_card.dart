import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarCard extends StatelessWidget {
  final double radius;

  const AvatarCard({super.key, this.radius = 50});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Container(
            width: radius * 2,
            height: radius * 2,
            alignment: Alignment.center,
            child: SizedBox(
              width: radius,
              height: radius,
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        String? avatarUrl;
        if (state is ProfileLoaded) {
          avatarUrl = state.user.avatar;
        }

        return Container(
          width: radius * 2,
          height: radius * 2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: ClipOval(
            child: avatarUrl != null && avatarUrl.isNotEmpty
                ? Image.network(
                    avatarUrl,
                    width: radius * 2,
                    height: radius * 2,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: SizedBox(
                          width: radius,
                          height: radius,
                          child:
                              const CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.person,
                          size: radius,
                          color: AppColors.primary.shade100,
                        ),
                      );
                    },
                  )
                : Center(
                    child: Icon(
                      Icons.person,
                      size: radius,
                      color: AppColors.primary.shade100,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
