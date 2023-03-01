import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/views/verify_view.dart';
import '../constants/routes.dart';
import 'login_view.dart';
import 'dart:developer' as dev;

import 'notes_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Note that homepage DOESN'T return a Scaffold.
    // Instead, it returns other widgets that return Scaffold.

    User? currUser = FirebaseAuth.instance.currentUser;
    // final emailVerified = currUser?.emailVerified ?? false;

    if (currUser != null) {
      print(currUser);

      if (currUser.emailVerified) {
        dev.log("HomePage: ${currUser.email} already logged in. Redirecting to notes.");
        return NotesView();
      } else {
        dev.log(
            "HomePage: ${currUser.email} already logged in but not verified. Redirecting to verify.");

        return VerifyEmailView();
      }
    }

    return LoginView();

/*
    return FutureBuilder(
        // Give the async task in future of Future Builder
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // Based on connectionState, show message (loading, active(streams), done)
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              print("ConnectionState.done");

              if (user == null) {
                Navigator.pushNamed(context, '/login');
                //return Text("User Info: ${user?.email}");
              } else {
                return Text("User Info: ${user.email}");
              }

            default:
              return const Text("Loading...");
          }
        });
  */
  }
}
