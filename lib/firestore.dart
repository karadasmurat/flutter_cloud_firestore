import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'model/car.dart';

// Initialize an instance of Cloud Firestore:
final FirebaseFirestore db = FirebaseFirestore.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var myCar = Car(2019, make: "Volkswagen");
  await addCar(myCar);
  getCars();
}

Future<String?> addCar(Car aCar) async {
  // Add a new document with a generated ID
  final doc = await db.collection("cars").add(aCar.toJson());
  print('DocumentSnapshot added with ID: ${doc.id}');
  return doc.id;
}

Future<String?> addUser() async {
  // Create a new user with a first and last name
  final user = <String, dynamic>{"first": "Ada", "last": "Lovelace", "born": 1815};

  // Add a new document with a generated ID
  final doc = await db.collection("users").add(user);
  print('DocumentSnapshot added with ID: ${doc.id}');
  return doc.id;
}

void getCars() async {
  await db.collection("cars").get().then((event) {
    for (var doc in event.docs) {
      print("${doc.id} => ${doc.data()}");
    }
  });
}
