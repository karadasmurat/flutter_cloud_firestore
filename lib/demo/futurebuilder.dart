import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/firestore.dart';
import 'package:flutter_cloud_firestore/model/car.dart';

class FutureBuilderDemo extends StatefulWidget {
  const FutureBuilderDemo({Key? key}) : super(key: key);

  @override
  State<FutureBuilderDemo> createState() => _FutureBuilderDemoState();
}

class _FutureBuilderDemoState extends State<FutureBuilderDemo> {
  var sampleCars = [
    Car(2007, make: "ALFA ROMEO"),
    Car(2019, make: "AUDI"),
    Car(2022, make: "BENTLEY"),
    Car(2007, make: "BMW"),
    Car(2019, make: "BUGATTI"),
    Car(2022, make: "CHEVROLET"),
    Car(2007, make: "CITROEN"),
    Car(2019, make: "DACIA"),
    Car(2022, make: "HONDA"),
    Car(2007, make: "HYUNDAI"),
    Car(2019, make: "FERRARI"),
    Car(2022, make: "FIAT"),
    Car(2007, make: "FORD"),
    Car(2019, make: "ISUZU"),
    Car(2022, make: "JAGUAR"),
    Car(2007, make: "JEEP"),
    Car(2019, make: "KIA"),
    Car(2022, make: "LADA"),
    Car(2007, make: "LAND ROVER"),
    Car(2019, make: "LEXUS"),
    Car(2022, make: "LINCOLN"),
  ];

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
          TextButton(
            onPressed: () {
              setState(() {
                _cars = addCar();
              });
            },
            child: const Text("Load"),
          ),
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
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.amber[100],
                                  backgroundImage: NetworkImage(logos[cars[index].make] ??
                                      "https://source.unsplash.com/random/200x200"),
                                ),
                                title: Text(cars[index].make),
                                subtitle: Text(cars[index].year.toString()),
                                trailing: const Icon(Icons.more_vert),
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
