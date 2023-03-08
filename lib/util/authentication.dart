/*
Documentation for Firebase Authentication on Flutter: 
https://firebase.google.com/docs/auth/flutter/start

 */

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

    final user = FirebaseAuth.instance.currentUser;

    // Get a user's profile
    if (user != null) {
      // profile photo URL
      final photoUrl = user.photoURL;
      print("Profile Information:");
      print("Photo: $photoUrl");
    }

    // Get a user's provider-specific profile information
    if (user != null) {
      for (final userInfo in user.providerData) {
        // ID of the provider (google.com, apple.cpm, etc.)
        final provider = userInfo.providerId;

        // UID specific to the provider
        final uid = userInfo.uid;

        // profile photo URL
        final profilePhoto = userInfo.photoURL;

        print("Provider specific profile information:");
        print(userInfo);
      }
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
