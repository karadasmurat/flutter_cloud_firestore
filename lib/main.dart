/*

https://firebase.google.com/docs

Add Firebase to your Flutter App: https://firebase.google.com/docs/flutter/setup

  * Install Flutter for your specific operating system
  * Install the Firebase CLI.
  * Log into Firebase using your Google account by running the following command    : $ firebase login
  * Install the FlutterFire CLI by running the following command from any directory : $ dart pub global activate flutterfire_cli
  * Use the FlutterFire CLI to configure your Flutter apps to connect to Firebase   : $ flutterfire configure

  * Add dependencies (From your Flutter project directory)
    -  install the core plugin: $ flutter pub add firebase_core
    -  $ flutterfire configure


  EXAMPLES on github
  https://github.com/firebase/flutterfire/blob/master/packages/firebase_auth/firebase_auth/example/


 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/demo/listview.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text("Demo App")),
        body: const ListViewDemo(),
      ),
    );
  }
}
