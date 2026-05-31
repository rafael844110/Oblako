import 'package:cullinarium/core/utils/snackbars/app_snackbars.dart';
import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/core/widgets/forms/app_text_form_field.dart';
import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/data/models/user_model.dart';
import 'package:cullinarium/features/profile/presentation/widgets/picker/profile_image_picker.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/core/theme/app_colors.dart';

class PersonalDetailsEditPage extends StatefulWidget {
  const PersonalDetailsEditPage({super.key});

  @override
  State<PersonalDetailsEditPage> createState() =>
      _PersonalDetailsEditPageState();
}

class _PersonalDetailsEditPageState extends State<PersonalDetailsEditPage>
    with AppSnackbars {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // If state is already loaded, fill fields immediately
    final profileState = context.read<ProfileCubit>().state;
    if (profileState is ProfileLoaded) {
      _populateFields(profileState.user);
    }
  }

  void _populateFields(dynamic user) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phoneNumber;
  }

  void _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final cubit = context.read<ProfileCubit>();
    final profileState = cubit.state;

    if (profileState is! ProfileLoaded) return;

    setState(() => _isLoading = true);

    final userType = profileState.userType;
    final currentUser = profileState.user;

    try {
      switch (userType) {
        case 'chef':
          final updatedChef = (currentUser as ChefModel).copyWith(
            name: _nameController.text,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
          );
          await cubit.updateChefProfile(chef: updatedChef);
          break;

        case 'author':
          final updatedAuthor = (currentUser as AuthorModel).copyWith(
            name: _nameController.text,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
          );
          await cubit.updateAuthorProfile(author: updatedAuthor);
          break;

        case 'user':
          final updatedUser = (currentUser as UserModel).copyWith(
            name: _nameController.text,
            email: _emailController.text,
            phoneNumber: _phoneController.text,
          );
          await cubit.updateUserData(updatedUser);
          break;

        default:
          throw Exception('Unknown user type');
      }
    } catch (e) {
      showErrorSnackbar(context: context, message: e.toString());
    }

    setState(() => _isLoading = false);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoaded && state.user is UserModel) {
          _populateFields(state.user as UserModel);
          showSuccessSnackbar(context: context, message: 'Profile updated');
          Navigator.pop(context);
        } else if (state is ProfileError) {
          showErrorSnackbar(context: context, message: state.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit Profile'),
          elevation: 0,
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _isLoading ? null : _saveProfile,
            ),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProfileLoaded) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProfileImagePicker(
                          imageUrl: state.user.avatar,
                          onImagePicked: (file) {
                            if (file != null) {
                              context.read<ProfileCubit>().updateProfileImage(
                                    imageFile: file,
                                    userType: state.userType,
                                  );
                            }
                          },
                        ),
                        const SizedBox(height: 32),
                        _buildPersonalInfoSection(),
                        const SizedBox(height: 32),
                        _buildContactInfoSection(),
                        const SizedBox(height: 40),
                        AppButton(
                          title: 'Save Changes',
                          margin: EdgeInsets.zero,
                          width: double.infinity,
                          onPressed: _isLoading ? () {} : _saveProfile,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(child: Text('Error loading profile'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Personal Information'),
        const SizedBox(height: 16),
        AppTextFormField(
          controller: _nameController,
          title: 'Full Name',
        ),
      ],
    );
  }

  Widget _buildContactInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Contact Information'),
        const SizedBox(height: 16),
        AppTextFormField(
          controller: _emailController,
          title: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        AppTextFormField(
          controller: _phoneController,
          title: 'Phone',
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
