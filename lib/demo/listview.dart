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
    //var widget = createSimpleListView();
    var widget = createSimpleListViewBuilder();

    return widget;
  }

  Widget createSimpleListView() {
    return ListView(
      children: const [
        Text("Data 1"),
        Text("Data 2"),
        Text("Data 3"),
        Text("Data 4"),
        Text("Data 5"),
      ],
    );
  }

  Widget createSimpleListViewBuilder() {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Text("Item $index");
        });
  }

  Widget createListViewBuilderFromAList() {
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
