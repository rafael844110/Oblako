import 'package:cullinarium/core/theme/app_colors.dart';
import 'package:cullinarium/core/widgets/forms/app_detailed_field.dart';
import 'package:flutter/material.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({
    super.key,
    this.onMenuItemsChanged,
    this.initialMenuItems,
  });

  final Function(List<String>)? onMenuItemsChanged;
  final List<String>? initialMenuItems;

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  List<String> _menuItems = [];

  @override
  void initState() {
    _menuItems = widget.initialMenuItems ?? [];

    super.initState();
  }

  void _addMenuItem() {
    final theme = Theme.of(context);
    final menuItemController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Add dish to menu',
          style: theme.textTheme.titleLarge,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: AppDetailedField(
          title: 'Menu',
          hint: 'Boso Lagman',
          controller: menuItemController,
          icon: Icons.restaurant,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (menuItemController.text.isNotEmpty) {
                setState(() {
                  _menuItems.add(menuItemController.text);
                  widget.onMenuItemsChanged?.call(_menuItems);
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _removeMenuItem(int index) {
    setState(() {
      _menuItems.removeAt(index);
      widget.onMenuItemsChanged?.call(_menuItems);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Menu Items', style: theme.textTheme.headlineMedium),
            TextButton.icon(
              onPressed: _addMenuItem,
              icon: const Icon(Icons.add),
              label: Text(
                'Add Dish',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        if (_menuItems.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'No dishes yet, add your signature dishes',
              style: theme.textTheme.titleSmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          )
        else
          ..._menuItems.map((item) => Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: Text(item),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeMenuItem(_menuItems.indexOf(item)),
                  ),
                ),
              )),
      ],
    );
  }
}
