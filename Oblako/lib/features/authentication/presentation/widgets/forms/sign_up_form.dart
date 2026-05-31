import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/data/services/user_service.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/core/utils/snackbars/app_snackbars.dart';
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/core/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.role,
    this.backButtonCallback,
  });

  final String role;
  final VoidCallback? backButtonCallback;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with AppSnackbars {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _signup() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || phone.isEmpty) {
      showErrorSnackbar(
        context: context,
        message: 'Please fill in all fields',
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signUp(
            email: email,
            password: password,
            phoneNumber: phone,
            name: name,
            role: widget.role,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.error != null) {
          showErrorSnackbar(
            context: context,
            message: state.error!,
          );
        }
        if (state.isAuthenticated) {
          context.router.replaceAll([AppBottomRoute()]);
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: kToolbarHeight),
              GestureDetector(
                onTap: () => widget.backButtonCallback?.call(),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: kToolbarHeight * 0.7),
              RichText(
                text: TextSpan(
                  text: 'Register as ',
                  style: theme.textTheme.displayLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: UserService.getRoleDisplayName(widget.role),
                      style: theme.textTheme.displayLarge!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: kToolbarHeight),
              AppTextFormField(
                title: 'Full Name',
                controller: nameController,
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                title: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                title: 'Phone',
                controller: phoneController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              AppTextFormField(
                title: 'Password',
                controller: passwordController,
                obscureText: true,
              ),
              const Spacer(),
              Center(
                child: AppButton(
                  width: size.width,
                  margin: const EdgeInsets.only(bottom: kToolbarHeight * 2),
                  title: state.isLoading ? 'Loading...' : 'Create',
                  color: Colors.black,
                  onPressed: state.isLoading ? () {} : _signup,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
