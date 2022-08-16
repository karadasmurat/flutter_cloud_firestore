Map<String, dynamic> carMap = {"year": 2015, "make": "VOLKSWAGEN", "model": "PASSAT"};

class Car {
  //variables
  String? id; //id is null before inserting into db
  final String make;
  String? model;
  final int year;

  //Parameterised Constructor with named parameters
  // One positional parameter (required by default): year
  // One named parameter, required : make
  // One named parameter (optional by default) : model
  Car(this.year, {required this.make, this.model, this.id});

  // factory Constructor to return a Car object from Map.
  factory Car.fromJson(Map<String, dynamic> aCarMap) => Car(aCarMap['year'],
      make: aCarMap['make'], model: aCarMap['model'], id: aCarMap['id']);

  Map<String, dynamic> toJson() =>
      <String, dynamic>{"id": id, "year": year, "make": make, "model": model};

  // By default, print(myCar) prints " Instance of 'Car' "
  @override
  String toString() {
    return "{id: $id, year: $year, make: $make, model: $model}";
  }

  Map<String, dynamic> toFirestore() => <String, dynamic>{
        if (id != null) "id": id,
        "year": year,
        "make": make,
        if (model != null) "model": model,
      };
}
