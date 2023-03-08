import 'package:flutter_cloud_firestore/services/auth/authuser.dart';

import 'authprovider.dart';
import 'authprovider_firebase.dart';

class AuthService implements AuthProvider {
  // delegate for actual implementation
  final AuthProvider authProvider;

  AuthService(this.authProvider);

  // redirective constructor
  // initialized with a DEFAULT delegate.
  // otherwise, first initialize an AuthProvider, then pass it to AuthService constructor.
  AuthService.firebase() : this(FirebaseAuthProvider());

  @override
  Future<AuthUser> createUser({required String email, required String password}) =>
      authProvider.createUser(email: email, password: password);

  @override
  AuthUser? get currentUser => authProvider.currentUser;

  @override
  Future<void> sendEmailVerification() => authProvider.sendEmailVerification();

  @override
  Future<void> sendPasswordResetEmail({required String email}) =>
      authProvider.sendPasswordResetEmail(email: email);

  @override
  Future<AuthUser> signIn({required String email, required String password}) =>
      authProvider.signIn(email: email, password: password);

  @override
  Future<AuthUser> signInWithGoogle() => authProvider.signInWithGoogle();

  @override
  Future<void> signOut() => authProvider.signOut();
}
