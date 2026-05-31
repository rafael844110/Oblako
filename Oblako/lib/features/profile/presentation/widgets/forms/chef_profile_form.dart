import 'package:cullinarium/core/widgets/buttons/app_button.dart';
import 'package:cullinarium/core/widgets/forms/app_detailed_field.dart';
import 'package:cullinarium/core/widgets/layout/image_holder.dart';
import 'package:cullinarium/features/profile/data/models/chefs/chef_details_model.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/profile/presentation/widgets/layout/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChefProfileForm extends StatefulWidget {
  final Function(ChefDetailsModel)? onSave;
  final ChefDetailsModel? initialData;

  const ChefProfileForm({
    super.key,
    this.onSave,
    this.initialData,
  });

  @override
  State<ChefProfileForm> createState() => _ChefProfileFormState();
}

class _ChefProfileFormState extends State<ChefProfileForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _kitchenController;
  late TextEditingController _extraKitchenController;
  late TextEditingController _guestsCapabilityController;
  late TextEditingController _workScheduleController;
  late TextEditingController _pricePerPersonController;
  bool _canGoToRegions = false;
  List<String> _menuItems = [];
  List<String> _images = [];

  @override
  void initState() {
    super.initState();
    _kitchenController =
        TextEditingController(text: widget.initialData?.kitchen ?? '');
    _extraKitchenController =
        TextEditingController(text: widget.initialData?.extraKitchen ?? '');
    _guestsCapabilityController = TextEditingController(
        text: widget.initialData?.guestsCapability.toString() ?? '');
    _workScheduleController =
        TextEditingController(text: widget.initialData?.workSchedule ?? '');
    _pricePerPersonController = TextEditingController(
        text: widget.initialData?.pricePerPerson.toString() ?? '');

    if (widget.initialData != null) {
      _menuItems = List.from(widget.initialData!.menu);
      _images = List.from(widget.initialData!.images);
      _canGoToRegions = widget.initialData!.canGoToRegions ?? false;
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final currentState = context.read<ProfileCubit>().state;

      if (currentState is ProfileLoaded) {
        // Create or update chef details
        final newChefDetails = ChefDetailsModel(
          kitchen: _kitchenController.text,
          extraKitchen: _extraKitchenController.text,
          guestsCapability: int.parse(_guestsCapabilityController.text),
          workSchedule: _workScheduleController.text,
          menu: _menuItems,
          pricePerPerson: double.parse(_pricePerPersonController.text),
          canGoToRegions: _canGoToRegions,
          images: _images,
        );

        // Update the user model
        final updatedUser = currentState.user.copyWith(
          chefDetails: newChefDetails,
        );

        // Update the profile in the cubit
        context.read<ProfileCubit>().updateChefProfile(chef: updatedUser);

        // Call the optional onSave callback
        widget.onSave?.call(newChefDetails);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chef details saved successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error: User not loaded')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chef Details', style: theme.textTheme.headlineLarge),
        elevation: 0,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ImageHolder(
                    title: 'Dish Photos',
                    images: _images,
                    onImagesChanged: (images) {
                      _images = images.map((f) => f.path).toList();
                    }),
                const SizedBox(height: 20),

                AppDetailedField(
                  title: 'Main Cuisine',
                  hint: 'Italian cuisine',
                  controller: _kitchenController,
                  icon: Icons.restaurant,
                ),
                const SizedBox(height: 16),

                AppDetailedField(
                  title: 'Additional Cuisine',
                  hint: 'Korean cuisine',
                  controller: _extraKitchenController,
                  icon: Icons.restaurant_menu,
                ),

                const SizedBox(height: 16),

                // Capacity and Pricing
                Row(
                  children: [
                    Expanded(
                      child: AppDetailedField(
                        title: 'Guests',
                        hint: '10-20 people',
                        controller: _guestsCapabilityController,
                        icon: Icons.people,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppDetailedField(
                        title: 'Price',
                        hint: '500-1000 KGS',
                        controller: _pricePerPersonController,
                        icon: Icons.attach_money,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                AppDetailedField(
                  title: 'Work Schedule',
                  hint: '10:00 AM - 10:00 PM',
                  controller: _workScheduleController,
                  icon: Icons.schedule,
                ),

                const SizedBox(height: 16),

                // Travel Option
                SwitchListTile(
                  title: Text(
                    'Travel to regions',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Text(
                    'Are you willing to travel to other regions?',
                    style: theme.textTheme.headlineSmall,
                  ),
                  value: _canGoToRegions,
                  onChanged: (value) => setState(() => _canGoToRegions = value),
                  secondary: const Icon(Icons.directions_car),
                ),
                const SizedBox(height: 16),

                // Menu Items
                MenuItems(
                  initialMenuItems: _menuItems,
                  onMenuItemsChanged: (items) {
                    setState(
                      () => _menuItems = items,
                    );
                  },
                ),
                const SizedBox(height: 24),

                // Save Button
                AppButton(
                  title: 'Save',
                  onPressed: _saveProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _kitchenController.dispose();
    _extraKitchenController.dispose();
    _guestsCapabilityController.dispose();
    _workScheduleController.dispose();
    _pricePerPersonController.dispose();
    super.dispose();
  }
}
