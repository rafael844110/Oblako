import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/core/utils/snackbars/app_snackbars.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/core/widgets/forms/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AppSnackbars {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned(
              child: Image.asset(
            'assets/layout/background.png',
            height: size.height,
            width: size.width,
            fit: BoxFit.cover,
          )),
          Positioned(
            bottom: kToolbarHeight,
            child: loginContent(),
          ),
          Positioned(
            top: kToolbarHeight,
            left: 20,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget loginContent() {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocListener<AuthCubit, AuthState>(
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
      child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kToolbarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/app_logo.png',
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 24),
              Text(
                'Login',
                style: theme.textTheme.displayLarge!.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              AppTextFormField(
                title: 'Email',
                controller: emailController,
              ),
              const SizedBox(height: 10),
              AppTextFormField(
                title: 'Password',
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {},
                child: const Text('Forgot password?'),
              ),
              const SizedBox(height: 10),
              Center(
                child: AppButton(
                  title: 'Sign In',
                  width: size.width,
                  color: Colors.black,
                  onPressed: () {
                    if (emailController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      showErrorSnackbar(
                        context: context,
                        message: 'Please fill in all fields',
                      );
                      return;
                    }
                    context.read<AuthCubit>().signIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                  },
                ),
              ),
              const SizedBox(height: kToolbarHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('No account?'),
                  TextButton(
                    onPressed: () {
                      context.router.pushNamed('/signup');
                    },
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
