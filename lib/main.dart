import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/demo/futurebuilder.dart';
import 'package:flutter_cloud_firestore/demo/listview.dart';
import 'package:flutter_cloud_firestore/model/car.dart';
import 'package:flutter_cloud_firestore/model/car_factory.dart';

void main() {
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
      home: const HomePage(title: 'Cloud Firebase Demo'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _num1;
  late Future<int> _num2;

  late Future<List<Car>> _sampleCars;

  var cars = <Car>[
    Car(2007, make: "KIA"),
    Car(2019, make: "VOLKSWAGEN", model: "T-ROC"),
    Car(2020, make: "VOLKSWAGEN", model: "Passat"),
  ];

  @override
  void initState() {
    super.initState();
    _num1 = getDataImmediately();

    // initialize Future value
    _num2 = getDataAsync();
    _sampleCars = CarFromFileFactory().createCars();
  }

  int getDataImmediately() {
    return Random().nextInt(100);
  }

  Future<int> getDataAsync() async {
    await Future.delayed(Duration(seconds: 3));
    return Random().nextInt(100);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilderDemo()
        // body: Column(children: [
        //   FutureBuilder<List<Car>>(
        //     future: _sampleCars,
        //     builder: (context, snapshot) {
        //       switch (snapshot.connectionState) {
        //         case ConnectionState.done:
        //           if (snapshot.hasData) {
        //             List<Car> cars = snapshot.data!;
        //             return Container(
        //               child: ListView.builder(
        //                 itemCount: snapshot.data!.length,
        //                 itemBuilder: (context, index) {
        //                   return Text("title here");
        //                 },
        //               ),
        //             );
        //           } else if (snapshot.hasError) {
        //             return const Text("Error");
        //           } else {
        //             return const Text("No data..");
        //           }
        //         default:
        //           return const CircularProgressIndicator();
        //       }
        //     },
        //   ),
        //   TextButton(
        //     onPressed: () {
        //       setState(() {
        //         _num1 = getDataImmediately();
        //         _num2 = getDataAsync();
        //       });
        //     },
        //     child: Text("Get Data"),
        //   ),
        // ]),
        );
  }
}
