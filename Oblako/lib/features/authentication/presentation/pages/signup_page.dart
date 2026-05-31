import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/authentication/presentation/widgets/forms/sign_up_form.dart';
import 'package:cullinarium/features/authentication/presentation/widgets/forms/sign_up_type_form.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final PageController _pageController = PageController();

  String role = 'guest';

  void goToFormPage() {
    _pageController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goToRolePage() {
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/layout/background.png',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          PageView(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              // Select role page
              SignUpTypeForm(
                onRoleSelected: (String selectedRole) {
                  setState(() {
                    role = selectedRole;
                  });
                  goToFormPage();
                },
              ),

              // Sign up form page
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                child: SignUpForm(
                  role: role,
                  backButtonCallback: goToRolePage,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
