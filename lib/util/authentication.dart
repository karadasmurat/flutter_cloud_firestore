import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  static Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    UserCredential? userCredential;

    try {
      //Start interactive sign-in process
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        // Optional clientId
        // clientId: '123.apps.googleusercontent.com',
        scopes: <String>[
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      ).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        print('The account already exists with a different credential');
      } else if (e.code == 'invalid-credential') {
        print('Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      print('Error occurred using Google Sign In. Try again.');
    }

    return userCredential;
  }

  static Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print('Error signing out.');
    }
  }
}
