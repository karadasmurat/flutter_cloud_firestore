Map<String, String> logos = {
  "ALFA ROMEO": "https://www.tech-worm.com/wp-content/uploads/2016/07/alfa-romeo.jpg",
  "AUDI": "https://logoeps.com/wp-content/uploads/2013/07/audi-eps-vector-logo.png",
  "BENTLEY":
      "https://d1yjjnpx0p53s8.cloudfront.net/styles/logo-thumbnail/s3/092012/bentley.jpg?itok=_0bO-d3M",
  "BMW":
      "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/BMW_logo_%28gray%29.svg/2048px-BMW_logo_%28gray%29.svg.png"
};

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
