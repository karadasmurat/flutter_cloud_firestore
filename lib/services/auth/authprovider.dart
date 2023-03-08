import 'package:firebase_auth/firebase_auth.dart';

import 'authuser.dart';

abstract class AuthProvider {
  AuthUser? get currentUser;

  Future<AuthUser> createUser({
    required String email,
    required String password,
  });

  Future<AuthUser> signIn({
    required String email,
    required String password,
  });

  Future<AuthUser> signInWithGoogle();

  Future<void> sendEmailVerification();

  Future<void> sendPasswordResetEmail({
    required String email,
  });

  Future<void> signOut();
}
