/*

FIREBASE IS OUR BACKEND - You can swap out any backend here ....

*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos/features/auth/domain/entities/app_user.dart';
import 'package:sos/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  // access to firebase
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // LOGIN: email & password
  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // attempt sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);

      // return user
      return user;
    } catch (e) {
      // print error
      throw Exception("login failed: $e");
    }
  }

  // REGISTER: email & password
  @override
  Future<AppUser?> registerWithEmailPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      // attempt sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      // create user
      AppUser user = AppUser(uid: userCredential.user!.uid, email: email);
      return user;
    } catch (e) {
      print("Firebase registration error: $e");
      throw Exception("registration failed: $e");
    }
  }

  // DELETE ACCOUNT
  @override
  Future<void> deleteAccount() async {
    try {
      // get current user
      final user = firebaseAuth.currentUser;

      // check if there is a logged in user
      if (user == null) throw Exception("No user is currently signed in.");

      // delete user account
      await user.delete();
      await logout();
    } catch (e) {
      throw Exception("delete account failed: $e");
    }
  }

  // GET CURRENT USER
  @override
  Future<AppUser?> getCurrentUser() async {
    // get current logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    // no logged in user
    if (firebaseUser == null) return null;

    // log in user exists
    return AppUser(uid: firebaseUser.uid, email: firebaseUser.email!);
  }

  // LOGOUT
  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  // RESET PASSWORD
  @override
  Future<String> sendPasswordResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return "Password reset email! Check your inbox.";
    } catch (e) {
      return "An error occurred while trying to send password reset email: $e";
    }
  }
}
