import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'car.dart';

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

abstract class CarFactory {
  Future<List<Car>> createCars();
}

class CarFromFileFactory implements CarFactory {
  @override
  Future<List<Car>> createCars() async {
    // read an asset, .json file
    var decodedJson = await loadCarsFromFile("assets/json/cars.json");

    if (decodedJson is List) {
      Iterable<Car> cars = decodedJson.map((e) => Car.fromJson(e));
      return Future.value(cars.toList());
    } else {
      List<Car> cars = [];
      cars.add(Car.fromJson(decodedJson));
      return cars;
    }
  }
}

class CarFromHttpFactory implements CarFactory {
  @override
  Future<List<Car>> createCars() async {
    // TODO
    // make an API call, and decode response.body
    // var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var cars = <Car>[];
    return Future.value(cars);
  }
}

dynamic loadCarsFromFile(String aFile) async {
  String todosFromJsonFile = await rootBundle.loadString(aFile);
  return jsonDecode(todosFromJsonFile);
}
