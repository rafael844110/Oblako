import 'package:cullinarium/features/chef/presentation/widgets/cards/chef_home_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/chef/presentation/cubit/chef_cubit.dart';
import 'package:cullinarium/features/chef/presentation/widgets/cards/chef_card.dart';

class ChefHorizontalScroll extends StatelessWidget {
  const ChefHorizontalScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<ChefCubit, ChefState>(
      builder: (context, state) {
        if (state is ChefLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ChefLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Top Chefs',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 150,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: state.chefs.length,
                  itemBuilder: (context, index) {
                    final chef = state.chefs[index];
                    return ChefHomeCard(chef: chef);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 12),
                ),
              ),
            ],
          );
        } else if (state is ChefError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        // Initial or unknown state
        return const SizedBox.shrink();
      },
    );
  }
}
