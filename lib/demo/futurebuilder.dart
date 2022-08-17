import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/firestore.dart';
import 'package:flutter_cloud_firestore/model/car.dart';
import 'package:flutter_cloud_firestore/views/car_view.dart';

import '../model/car_factory.dart';

class FutureBuilderDemo extends StatefulWidget {
  const FutureBuilderDemo({Key? key}) : super(key: key);

  @override
  State<FutureBuilderDemo> createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  //FutureBuilder's future variable:
  late Future<List<Car>?> _cars;

  @override
  void initState() {
    super.initState();

    _cars = loadCars();
  }

  Future<List<Car>?> loadCars() async {
    // simulate waiting time, then return a static list:
    // await Future.delayed(const Duration(seconds: 3));
    // return sampleCars;

    // get documents from firestore
    var cars = await getAllCars();
    return cars;

    // we can return null, as return type is Future<List<Car>?>
    // snapshot.hasData is false in this case
    // return null;
  }

  Future<List<Car>> addCar() async {
    await Future.delayed(const Duration(seconds: 3));
    sampleCars.add(Car(2000, make: "CUSTOM"));
    return sampleCars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FutureBuilder Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<Car>?>(
              future: _cars,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    if (snapshot.hasData) {
                      var cars = snapshot.data!;

                      return Flexible(
                        child: ListView.builder(
                            itemCount: cars.length,
                            itemBuilder: (context, index) {
                              var car = cars[index];
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.amber[100],
                                  backgroundImage: NetworkImage(logos[car.make] ??
                                      "https://source.unsplash.com/random/200x200/?car&sig=$index"),
                                ),
                                title: Text(car.make),
                                subtitle: Text(car.year.toString()),
                                trailing: const Icon(Icons.arrow_right),
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => CarPage(car),
                                    ),
                                  );
                                },
                              );
                            }),
                      );
                    } else if (snapshot.hasError) {
                      final err = snapshot.error;
                      return Text("Error loading data: $err");
                    } else {
                      return const Text("No data..");
                    }

                  default:
                    return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
