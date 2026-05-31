import 'package:auto_route/auto_route.dart';
import 'package:cullinarium/features/chef/presentation/cubit/chef_cubit.dart';
import 'package:cullinarium/features/chef/presentation/widgets/layout/chef_horizontal_scroll.dart';
import 'package:cullinarium/features/home/presentation/widgets/ad_banner.dart';
import 'package:cullinarium/features/home/presentation/widgets/layout/app_header.dart';
import 'package:cullinarium/features/home/presentation/widgets/lists/category_list.dart';
import 'package:cullinarium/features/profile/data/datasources/profile_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<ChefCubit>().fetchChefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        height: size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: kToolbarHeight + 20),
            AppHeader(),
            const AdBanner(),
            const SizedBox(height: 20),
            const CategoryList(),
            const SizedBox(height: 20),
            ChefHorizontalScroll(),
          ],
        ),
      ),
    );
  }
}
