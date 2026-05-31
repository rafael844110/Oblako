import 'dart:async';

import 'package:cullinarium/features/authentication/data/datasources/remote/auth_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cullinarium/features/authentication/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  late final StreamSubscription<dynamic> _authSub;

  AuthCubit({required AuthService authService})
      : _authService = authService,
        super(AuthState(isLoading: true)) {
    _authSub = _authService.authChanges.listen(_onAuthStateChanged);
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true));
      var currentUser = await _authService.getCurrentUserData();

      if (currentUser != null) {
        emit(state.copyWith(
          isAuthenticated: true,
          user: currentUser,
          isLoading: false,
        ));
      } else {
        emit(state.copyWith(
          isAuthenticated: false,
          user: null,
          isLoading: false,
        ));
      }
    } catch (error) {
      emit(state.copyWith(error: error.toString()));
      emit(stableState.copyWith(isLoading: false));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    required String phoneNumber,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = await _authService.signUp(
        email: email,
        password: password,
        name: name,
        phoneNumber: phoneNumber,
        role: role,
      );

      emit(state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));

      final user = await _authService.signIn(
        email: email,
        password: password,
      );

      emit(state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> resetPassword({required String email}) async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await _authService.resetPassword(email: email);
      emit(state.copyWith(isResetEmailSent: true, isLoading: false));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> signOut() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await _authService.signOut();
      emit(state.copyWith(
        isAuthenticated: false,
        user: null,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(error: error.toString(), isLoading: false));
    }
  }

  Future<void> deleteAccount() async {
    final stableState = state;
    try {
      emit(state.copyWith(isLoading: true, error: null));
      await _authService.deleteAccount();
      emit(state.copyWith(
        isAuthenticated: false,
        user: null,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(error: error.toString(), isLoading: false));
      emit(stableState.copyWith(error: error.toString(), isLoading: false));
    }
  }

  void _onAuthStateChanged(dynamic user) async {
    if (user != null) {
      // In mock service, authChanges returns the user data directly
      // So we might not need to call getCurrentUserData again, but let's keep it safe or just use 'user'
      // If 'user' is the User/Chef/Author model, we can just use it.
      // Let's assume authChanges emits the user object.
      emit(state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      ));
    } else {
      emit(state.copyWith(
        isAuthenticated: false,
        user: null,
        isLoading: false,
      ));
    }
  }

  @override
  Future<void> close() {
    _authSub.cancel();
    return super.close();
  }
}
