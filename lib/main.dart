import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/demo/futurebuilder.dart';
import 'package:flutter_cloud_firestore/demo/listview.dart';
import 'package:flutter_cloud_firestore/demo/streambuilder.dart';
import 'package:flutter_cloud_firestore/firestore_stream.dart';

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
        appBar: AppBar(title: Text("Demo App")),
        body: const ListViewDemo(),
      ),
    );
  }
}
