import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/core/widgets/animations/app_loading_screen.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';
import 'package:cullinarium/features/authentication/presentation/pages/login_page.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/widgets/layout/profile_error_view.dart';
import 'package:cullinarium/features/profile/presentation/widgets/layout/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

@RoutePage()
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    context.read<ProfileCubit>().initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const AppLoadingScreen();
        }
        if (state.isAuthenticated) {
          return BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, pState) {
              return Scaffold(
                body: pState is ProfileLoading
                    ? Center(
                        child: LoadingAnimationWidget.waveDots(
                          color: AppColors.primary,
                          size: 32,
                        ),
                      )
                    : pState is ProfileError
                        ? const ProfileErrorView()
                        : pState is ProfileLoaded
                            ? ProfileView(state: pState)
                            : const Center(
                                child: Text('Initializing profile...'),
                              ),
              );
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
