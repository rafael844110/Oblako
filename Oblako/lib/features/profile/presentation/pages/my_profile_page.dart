import 'package:cullinarium/core/utils/dialogs/confirmation_dialogs.dart';
import 'package:cullinarium/features/profile/data/controllers/profile_data_controllers.dart';
import 'package:cullinarium/features/profile/data/models/author_model.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_model.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/widgets/components/profile_edit_mode_component.dart';
import 'package:cullinarium/features/profile/presentation/widgets/components/profile_view_mode_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage>
    with ConfirmationDialogs {
  bool _isEditing = false;
  bool _hasChanges = false;

  // Profile data controllers - shared between view and edit modes
  final ProfileDataControllers _controllers = ProfileDataControllers();

  @override
  void dispose() {
    _controllers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: theme.textTheme.displayMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => _handleBackPress(),
        ),
        actions: [
          BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoaded) {
                return IconButton(
                  icon: Icon(
                    _isEditing ? Icons.close : Icons.edit,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    if (_isEditing && _hasChanges) {
                      _showDiscardChangesDialog();
                    } else {
                      setState(() {
                        _isEditing = !_isEditing;
                        if (!_isEditing) {
                          _controllers.initializeFromProfile(state.user);
                        }
                      });
                    }
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoaded && !_isEditing) {
            _controllers.initializeFromProfile(state.user);
          }
        },
        builder: (context, state) {
          if (state is ProfileInitial || state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileCubit>().initialize(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileLoaded) {
            // Always keep controllers synced with state.user
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _controllers.initializeFromProfile(state.user);
            });

            return _isEditing
                ? ProfileEditMode(
                    controllers: _controllers,
                    userType: state.userType,
                    userData: state.user,
                    onSave: () => _saveProfile(state),
                    onChanged: (_) {},
                    // onChanged: (hasChanges) {
                    //   setState(() {
                    //     _hasChanges = hasChanges;
                    //   });
                    // },
                  )
                : ProfileViewMode(
                    userType: state.userType,
                    userData: state.user,
                    controllers: _controllers,
                  );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  void _handleBackPress() {
    if (_isEditing && _hasChanges) {
      _showDiscardChangesDialog();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _showDiscardChangesDialog() async {
    final discard = await showDiscardConfirmationDialog(
      context: context,
    );

    if (discard == true) {
      setState(() {
        _isEditing = false;
        _hasChanges = false;

        final state = context.read<ProfileCubit>().state;
        if (state is ProfileLoaded) {
          _controllers.initializeFromProfile(state.user);
        }
      });
    }
  }

  void _saveProfile(ProfileLoaded state) async {
    _showLoadingDialog();

    try {
      if (state.userType == 'chef') {
        final chef = state.user as ChefModel;
        final updatedChef = _controllers.createUpdatedChef(chef);
        await context.read<ProfileCubit>().updateChefProfile(chef: updatedChef);
      } else if (state.userType == 'author') {
        final author = state.user as AuthorModel;
        final updatedAuthor = _controllers.createUpdatedAuthor(author);
        await context
            .read<ProfileCubit>()
            .updateAuthorProfile(author: updatedAuthor);
      }

      if (context.mounted) {
        Navigator.of(context).pop(); // Remove loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully'),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          _isEditing = false;
          _hasChanges = false;
        });
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.of(context).pop(); // Remove loading dialog

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating profile: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Updating profile...'),
          ],
        ),
      ),
    );
  }
}
