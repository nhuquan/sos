/*

Cubits are responsible for state management -> to show the appropriate stuff on screen

*/

import 'package:sos/features/auth/domain/entities/app_user.dart';
import 'package:sos/features/auth/domain/repos/auth_repo.dart';
import 'package:sos/features/auth/presentation/cubits/auth_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // get current user
  AppUser? get currentUser => _currentUser;

  // check if user is authenticated
  void checkAuth() async {
    // loading..
    emit(AuthLoading());

    // get current user
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  // Login with email & password
  Future<void> login(String email, String password) async {
    try {
      // loading..
      emit(AuthLoading());

      // attempt login
      final AppUser? user = await authRepo.loginWithEmailPassword(
        email,
        password,
      );

      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  // Register with email & password
  Future<void> register(String name, String email, String password) async {
    try {
      // loading..
      emit(AuthLoading());

      // attempt registration
      final AppUser? user = await authRepo.registerWithEmailPassword(
        name,
        email,
        password,
      );

      if (user != null) {
        _currentUser = user;
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }

  // Logout
  Future<void> logout() async {
    emit(AuthLoading());

    // attempt logout
    await authRepo.logout();
    emit(AuthUnauthenticated());
  }

  // Forgot password
  Future<String> forgotPassword(String email) async {
    try {
      emit(AuthLoading());
      final String res = await authRepo.sendPasswordResetEmail(email);
      emit(AuthUnauthenticated());
      return res;
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
      return "error";
    }
  }

  // Delete account
  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await authRepo.deleteAccount();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(AuthUnauthenticated());
    }
  }


}
