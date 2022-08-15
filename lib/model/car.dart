Map<String, dynamic> carMap = {"year": 2015, "make": "VOLKSWAGEN", "model": "PASSAT"};

class Car {
  //variables
  final String make;
  String? model;
  final int year;

  //Parameterised Constructor with named parameters
  // One positional parameter (required by default): year
  // One named parameter, required : make
  // One named parameter (optional by default) : model
  Car(this.year, {required this.make, this.model});

  // factory Constructor to return a Car object from Map.
  factory Car.fromJson(Map<String, dynamic> aCarMap) => Car(
        aCarMap['year'],
        make: aCarMap['make'],
        model: aCarMap['model'],
      );

  Map<String, dynamic> toJson() => {"make": make, "model": model, "year": year};

  // By default, print(myCar) prints " Instance of 'Car' "
  @override
  String toString() {
    return "{make: $make, model: $model, year: $year}";
  }
}
