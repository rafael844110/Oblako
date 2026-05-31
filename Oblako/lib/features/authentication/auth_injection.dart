import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cullinarium/core/di/injections.dart';
import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> authInjection() async {
  sl.registerLazySingleton<AuthService>(() => AuthService(
        FirebaseAuth.instance,
        FirebaseFirestore.instance,
      ));

  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      authService: sl<AuthService>(),
    )..loadInitialData(),
  );
}
