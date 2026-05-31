import 'package:cullinarium/core/di/injections.dart';
import 'package:cullinarium/core/navigation/app_router.dart';
import 'package:cullinarium/core/theme/app_theme.dart';
import 'package:cullinarium/features/ai_bot/presentation/cubit/ai_bot_cubit.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:cullinarium/features/chef/presentation/cubit/chef_cubit.dart';
import 'package:cullinarium/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cullinarium/features/recipe/presentation/cubit/recipe_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = sl<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()),
        BlocProvider(create: (_) => sl<ProfileCubit>()),
        BlocProvider(create: (_) => sl<AiBotCubit>()),
        BlocProvider(create: (_) => sl<ChefCubit>()),
        BlocProvider(create: (_) => sl<RecipeCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Culinarium',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
      ),
    );
  }
}
