import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'car.dart';

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
