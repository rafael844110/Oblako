import 'package:cullinarium/features/chef/presentation/widgets/cards/chef_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/chef/presentation/cubit/chef_cubit.dart';

class ChefsPage extends StatefulWidget {
  const ChefsPage({super.key});

  @override
  State<ChefsPage> createState() => _ChefsPageState();
}

class _ChefsPageState extends State<ChefsPage> {
  @override
  void initState() {
    context.read<ChefCubit>().fetchChefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocBuilder<ChefCubit, ChefState>(
      builder: (context, state) {
        if (state is ChefLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChefLoaded) {
          return SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                const SizedBox(height: kToolbarHeight),
                Text(
                  'Chefs',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8),
                  itemCount: state.chefs.length,
                  itemBuilder: (context, index) {
                    final chef = state.chefs[index];
                    return ChefCard(chef: chef);
                  },
                ),
              ],
            ),
          );
        } else if (state is ChefError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        // Initial state
        return SizedBox(
          width: size.width,
          child: Column(
            children: [
              const Text('Chefs'),
              ElevatedButton(
                onPressed: () {
                  context.read<ChefCubit>().fetchChefs();
                },
                child: const Text('Load Chefs'),
              ),
            ],
          ),
        );
      },
    );
  }
}
