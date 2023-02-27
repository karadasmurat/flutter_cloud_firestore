import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_view.dart';
import 'dart:developer' as dev;

import 'notes_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currUser = FirebaseAuth.instance.currentUser;
    if (currUser != null) {
      dev.log("${currUser.email} already logged in. Redirecting to /notes.");
      return NotesView();
      //Navigator.pushNamed(context, '/login');
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
