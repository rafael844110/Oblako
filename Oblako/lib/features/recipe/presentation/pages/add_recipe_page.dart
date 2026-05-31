import 'package:cullinarium/features/recipe/data/models/ingredient_model.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddRecipePage extends StatefulWidget {
  final bool isEditMode;

  const AddRecipePage({
    super.key,
    this.isEditMode = false,
  });

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  @override
  void initState() {
    super.initState();

    // If we're in edit mode and there's a selectedRecipe, load it into the form
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RecipeCubit cubit = context.read<RecipeCubit>();
      if (widget.isEditMode && cubit.state.selectedRecipe != null) {
        cubit.loadRecipeForEdit(cubit.state.selectedRecipe!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeCubit, RecipeState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.isEditMode
                  ? 'Recipe updated successfully'
                  : 'Recipe added successfully'),
            ),
          );
          Navigator.of(context).pop();
        }

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage!)),
          );
        }
      },
      builder: (context, state) {
        // Determine if we're in edit mode based on the widget parameter
        // and if we have a selected recipe
        final bool isEditing =
            widget.isEditMode && state.selectedRecipe != null;

        return Scaffold(
          appBar: AppBar(
            title: Text(isEditing ? 'Edit Recipe' : 'Add Recipe'),
            // Add a reset button for edit mode
            actions: isEditing
                ? [
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reset Changes',
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Reset Changes?'),
                            content: const Text(
                              'This will reset all changes you\'ve made back to the original recipe.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  context
                                      .read<RecipeCubit>()
                                      .loadRecipeForEdit(state.selectedRecipe!);
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ]
                : null,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Recipe title
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: state.title,
                  onChanged: (value) =>
                      context.read<RecipeCubit>().titleChanged(value),
                ),
                const SizedBox(height: 16),

                // Recipe description
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: state.description,
                  maxLines: 3,
                  onChanged: (value) =>
                      context.read<RecipeCubit>().descriptionChanged(value),
                ),
                const SizedBox(height: 16),

                // Image URL
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Image URL',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: state.imageUrl,
                  onChanged: (value) =>
                      context.read<RecipeCubit>().imageUrlChanged(value),
                ),
                const SizedBox(height: 16),

                // Categories
                Text('Categories',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    ...state.categories.map((category) => Chip(
                          label: Text(category),
                          onDeleted: () => context
                              .read<RecipeCubit>()
                              .removeCategory(category),
                        )),
                    ActionChip(
                      avatar: const Icon(Icons.add),
                      label: const Text('Add Category'),
                      onPressed: () {
                        // Show dialog to add new category
                        showDialog(
                          context: context,
                          builder: (context) =>
                              _buildAddCategoryDialog(context),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Ingredients section
                Text('Ingredients',
                    style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.ingredients.length,
                  itemBuilder: (context, index) {
                    final ingredient = state.ingredients[index];
                    return ListTile(
                      title: Text(
                          '${ingredient.quantity} ${ingredient.unit} ${ingredient.name}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () =>
                            context.read<RecipeCubit>().removeIngredient(index),
                      ),
                      onTap: () {
                        // Show dialog to edit ingredient
                        showDialog(
                          context: context,
                          builder: (context) =>
                              _buildIngredientDialog(context, index),
                        );
                      },
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Ingredient'),
                  onPressed: () {
                    // Show dialog to add new ingredient
                    showDialog(
                      context: context,
                      builder: (context) => _buildIngredientDialog(context),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Steps section
                Text('Steps', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.steps.length,
                  onReorder: (oldIndex, newIndex) {
                    context
                        .read<RecipeCubit>()
                        .reorderSteps(oldIndex, newIndex);
                  },
                  itemBuilder: (context, index) {
                    final step = state.steps[index];
                    return ListTile(
                      key: ValueKey('step_$index'),
                      leading: CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                      title: Text(step),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Show dialog to edit step
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    _buildStepDialog(context, index),
                              );
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () =>
                                context.read<RecipeCubit>().removeStep(index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Step'),
                  onPressed: () {
                    // Show dialog to add new step
                    showDialog(
                      context: context,
                      builder: (context) => _buildStepDialog(context),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Cooking info
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Prep Time (minutes)',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: state.prepTimeMinutes.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => context
                            .read<RecipeCubit>()
                            .prepTimeChanged(int.tryParse(value) ?? 0),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Cook Time (minutes)',
                          border: OutlineInputBorder(),
                        ),
                        initialValue: state.cookTimeMinutes.toString(),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => context
                            .read<RecipeCubit>()
                            .cookTimeChanged(int.tryParse(value) ?? 0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Servings',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: state.servings.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => context
                      .read<RecipeCubit>()
                      .servingsChanged(int.tryParse(value) ?? 1),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: state.isSubmitting
                        ? null
                        : () {
                            if (isEditing) {
                              context.read<RecipeCubit>().updateRecipe();
                            } else {
                              context.read<RecipeCubit>().submitRecipe();
                            }
                          },
                    child: state.isSubmitting
                        ? const CircularProgressIndicator()
                        : Text(isEditing ? 'Update Recipe' : 'Add Recipe'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog for adding/editing categories
  Widget _buildAddCategoryDialog(BuildContext context) {
    final TextEditingController _categoryController = TextEditingController();

    return AlertDialog(
      title: const Text('Add Category'),
      content: TextField(
        controller: _categoryController,
        decoration: const InputDecoration(labelText: 'Category'),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_categoryController.text.isNotEmpty) {
              context.read<RecipeCubit>().addCategory(_categoryController.text);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  // Dialog for adding/editing ingredients
  Widget _buildIngredientDialog(BuildContext context, [int? editIndex]) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _quantityController = TextEditingController();
    final TextEditingController _unitController = TextEditingController();

    if (editIndex != null) {
      final ingredient =
          context.read<RecipeCubit>().state.ingredients[editIndex];
      _nameController.text = ingredient.name;
      _quantityController.text = ingredient.quantity.toString();
      _unitController.text = ingredient.unit;
    }

    return AlertDialog(
      title: Text(editIndex == null ? 'Add Ingredient' : 'Edit Ingredient'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name (e.g., Flour)'),
            autofocus: true,
          ),
          TextField(
            controller: _quantityController,
            decoration: const InputDecoration(labelText: 'Quantity (e.g., 2)'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _unitController,
            decoration: const InputDecoration(labelText: 'Unit (e.g., cups)'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_nameController.text.isNotEmpty) {
              final ingredient = IngredientModel(
                name: _nameController.text,
                quantity: double.tryParse(_quantityController.text) ?? 0,
                unit: _unitController.text,
              );

              if (editIndex != null) {
                context
                    .read<RecipeCubit>()
                    .updateIngredient(editIndex, ingredient);
              } else {
                context.read<RecipeCubit>().addIngredient(ingredient);
              }

              Navigator.of(context).pop();
            }
          },
          child: Text(editIndex == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }

  // Dialog for adding/editing steps
  Widget _buildStepDialog(BuildContext context, [int? editIndex]) {
    final TextEditingController _stepController = TextEditingController();

    if (editIndex != null) {
      _stepController.text = context.read<RecipeCubit>().state.steps[editIndex];
    }

    return AlertDialog(
      title: Text(editIndex == null ? 'Add Step' : 'Edit Step'),
      content: TextField(
        controller: _stepController,
        decoration: const InputDecoration(labelText: 'Instructions'),
        autofocus: true,
        maxLines: 3,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (_stepController.text.isNotEmpty) {
              if (editIndex != null) {
                context
                    .read<RecipeCubit>()
                    .updateStep(editIndex, _stepController.text);
              } else {
                context.read<RecipeCubit>().addStep(_stepController.text);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text(editIndex == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
