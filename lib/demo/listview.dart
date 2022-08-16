import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/model/car.dart';

class ListViewDemo extends StatefulWidget {
  const ListViewDemo({Key? key}) : super(key: key);

  @override
  State<ListViewDemo> createState() => _ListViewDemoState();
}

class _ListViewDemoState extends State<ListViewDemo> {
  List<Car> cars = [
    Car(2007, make: "KIA"),
    Car(2019, make: "VOLKSWAGEN"),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.drive_eta),
            title: Text(cars[index].make),
            trailing: const Icon(Icons.more_vert),
          );
        });
  }
}
