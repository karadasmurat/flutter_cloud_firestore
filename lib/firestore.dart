import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_cloud_firestore/model/car_factory.dart';
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

  // write some data about cities
  //addCities();

  // CarFactory carFactory = CarFromFileFactory();
  // var cars = await carFactory.createCars();
  // for (var car in cars) {
  //   await addCar(car);
  // }

  // var myCar = Car(2023, make: "MSL");
  // myCar = await addCar(myCar);

  //getCars();
  var cars = await getCarsByMake("VOLKSWAGEN");
  print("here are the results: $cars");

  // myCar.model = "KRDS";
  // updateCar(myCar);

  // var updatedCar = getCarById(myCar.id!);
  // print(updatedCar);
}

// Set the data of a document, explicitly specifying a document identifier.
// If the document does not exist, it will be created. If the document does exist, its contents will be overwritten with the newly provided data
addCities() {
  final cities = db.collection("cities");
  final data1 = <String, dynamic>{
    "name": "San Francisco",
    "state": "CA",
    "country": "USA",
    "capital": false,
    "population": 860000,
    "regions": ["west_coast", "norcal"]
  };
  cities.doc("SF").set(data1);

  final data2 = <String, dynamic>{
    "name": "Los Angeles",
    "state": "CA",
    "country": "USA",
    "capital": false,
    "population": 3900000,
    "regions": ["west_coast", "socal"],
  };
  cities.doc("LA").set(data2);

  final data3 = <String, dynamic>{
    "name": "Washington D.C.",
    "state": null,
    "country": "USA",
    "capital": true,
    "population": 680000,
    "regions": ["east_coast"]
  };
  cities.doc("DC").set(data3);

  final data4 = <String, dynamic>{
    "name": "Tokyo",
    "state": null,
    "country": "Japan",
    "capital": true,
    "population": 9000000,
    "regions": ["kanto", "honshu"]
  };
  cities.doc("TOK").set(data4);

  final data5 = <String, dynamic>{
    "name": "Beijing",
    "state": null,
    "country": "China",
    "capital": true,
    "population": 21500000,
    "regions": ["jingjinji", "hebei"],
  };
  cities.doc("BJ").set(data5);
}

// Add a new document to a collection.
// In this case, Cloud Firestore automatically generates the document identifier.
Future<Car> addCar(Car aCar) async {
  // Add a new document with a generated ID
  final collRef = db.collection("cars");
  final docRef = await collRef.add(aCar.toFirestore());
  print('DocumentSnapshot added with ID: ${docRef.id}');
  aCar.id = docRef.id;
  return aCar;
}

Future<void> updateCar(Car aCar) async {
  var docRef = db.collection("cars").doc(aCar.id);
  try {
    await docRef.set(aCar.toFirestore());
    print("DocumentSnapshot successfully updated!");
  } catch (e) {
    print("Error updating document $e");
  }

  // To update some fields of a document without overwriting the entire document, use the update() method:
  docRef.update({"timestamp": FieldValue.serverTimestamp()}).then(
      (value) => print("DocumentSnapshot successfully updated!"),
      onError: (e) => print("Error updating document $e"));
}

Future<Car?> getCarById(String carId) async {
  final docRef = db.collection("cars").doc(carId);
  // Retrieve the contents of a single document (DocumentSnapshot) using get():
  docRef.get().then((docSnapshot) {
    final data = docSnapshot.data() as Map<String, dynamic>;
    return Car.fromJson(data);
  }, onError: (e) => print("Error reading document: $e"));
}

Future<List<Car>?> getCarsByMake(String aMake) async {
  var query = db.collection("cars").where("make", isEqualTo: aMake);
  var querySnapshot = await query.get();
  print("Successfully completed with results: ${querySnapshot.docs.length}");
  Iterable<Car> cars = querySnapshot.docs.map((e) => Car.fromJson(e.data()));
  return cars.toList();
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
