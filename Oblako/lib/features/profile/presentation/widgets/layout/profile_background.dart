import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/core/utils/dialogs/app_confirmation_mixin.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBackground extends StatefulWidget {
  const ProfileBackground({super.key, this.image});

  final String? image;

  @override
  State<ProfileBackground> createState() => _ProfileBackgroundState();
}

class _ProfileBackgroundState extends State<ProfileBackground>
    with AppConfirmationMixin {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(200),
              bottomRight: Radius.circular(200),
            ),
          ),
          width: size.width,
        ),
        Positioned(
          bottom: -kToolbarHeight * 1.2,
          child: CircleAvatar(
            backgroundColor: Colors.black,
            radius: 100,
            child: widget.image != null
                ? Image.network(
                    widget.image!,
                    fit: BoxFit.cover,
                    width: 200,
                    height: 200,
                  )
                : const Icon(
                    Icons.person,
                    size: 100,
                    color: Colors.white,
                  ),
          ),
        ),
        Positioned(
          top: kToolbarHeight,
          left: 20,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Positioned(
          top: kToolbarHeight,
          right: 60,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        Positioned(
          top: kToolbarHeight,
          right: 20,
          child: IconButton(
            onPressed: () => _handleLogout(),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleLogout() async {
    final confirmed = await confirmLogout();
    if (confirmed && mounted) {
      context.read<AuthCubit>().signOut();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logged out!')),
      );
    }
  }
}
