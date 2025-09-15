/* 

Auth States

*/

import 'package:sos/features/auth/domain/entities/app_user.dart';

abstract class AuthState {

}

// initial
class AuthInitial extends AuthState {}

// loading..
class AuthLoading extends AuthState {}

// authenticated
class AuthAuthenticated extends AuthState {
  final AppUser user;
  AuthAuthenticated(this.user);
}

// unauthenticated
class AuthUnauthenticated extends AuthState {}

// error..
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
} 