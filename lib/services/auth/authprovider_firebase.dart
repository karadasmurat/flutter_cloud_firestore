import 'dart:developer' as dev;
import 'package:google_sign_in/google_sign_in.dart';

import 'authprovider.dart';
import 'authuser.dart';
import 'authexceptions.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    late AuthUser auser; // to return an AuthUser

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Signed in
      final user = userCredential.user;
      if (user != null) {
        auser = AuthUser.fromFirebaseUser(user);
      } else {
        throw GenericAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException(e.message);
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseAuthException(e.message);
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailAuthException(e.message);
      }
    } catch (e) {
      dev.log(e.toString());
      throw GenericAuthException();
    }

    return auser;
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    late AuthUser auser;

    try {
      // Once signed in, get the UserCredential
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // Signed in
      final user = userCredential.user;
      if (user != null) {
        auser = AuthUser.fromFirebaseUser(user);
      } else {
        throw GenericAuthException();
      }

      dev.log("User Info: $user");
    } on FirebaseAuthException catch (e) {
      dev.log('Use FirebaseAuthException to throw a custom exception : ${e.code}');

      // give different reactions to different errors if required
      if (e.code == 'user-not-found') {
        dev.log("Wrap 'user-not-found' and throw ");
        throw UserNotFoundAuthException(e.message);
      } else if (e.code == 'wrong-password') {
        dev.log('WRONG PASSWORD custom message.');
        throw WrongPasswordAuthException(e.message);
      }
    } catch (e) {
      dev.log(e.toString());
      throw GenericAuthException();
    }

    return auser;
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, get the UserCredential
    final uc = await FirebaseAuth.instance.signInWithCredential(credential);

    // MK - return AuthUser
    if (uc.user != null) {
      return AuthUser.fromFirebaseUser(uc.user!);
    } else {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    // note that the user isn't signedIn, method is on FirebaseAuth
    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: email,
    );
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // note that the user is signedIn, method is on User.
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  // Getter
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return null;
    }
    return AuthUser.fromFirebaseUser(user);
  }
}
