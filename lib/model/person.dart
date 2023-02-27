// Use the abstract modifier to define an abstract class.
// An abstract class is one whose main purpose is to define a common interface for its subclasses.
// An abstract class will defer some or all of its implementation to operations defined in subclasses;
// hence an abstract class cannot be instantiated.
// The operations that an abstract class declares but doesn't implement are called abstract operations.

// Clients only know about the abstract class(es) defining the interface.
// Clients remain unaware of the specific types of objects they use,
// as long as the objects adhere to the interface that clients expect.

// The superclass, or parent class (sometimes called base class),
// contains all the attributes and behaviors that are common to classes that inherit from it.

class Person {
// abstract class Person {

  String lastName; // non-nullable, lets make it positional
  String firstName; // non-nullable, lets make required named parameter
  String? middleName; // nullable, lets make it optional
  int birthYear; // non-nullable, lets make it optional with a default value of 1900

  Person(this.lastName,
      {required this.firstName, this.middleName, this.birthYear = 1900});

  void sayHi() {
    print("Hi, this is this $lastName, $firstName");
  }

  void goodBye() {
    print("Got to go now. See you later!");
  }

  // abstract method, without a body.
  // Implementations must be present in the concrete subclass.
  // void introduce();

  @override
  String toString() =>
      '{"fn": "$firstName", "m": "$middleName", "ln": "$lastName", "by": $birthYear}';
}

class Staff extends Person {
  // new field definition
  String department;

  // also calling related super constructor
  Staff(super.lastName, {required super.firstName, this.department = "Pool"});

  @override
  void introduce() {
    print("This is $lastName from $department.");
  }

  // A new, specific to Staff method definition
  void staffSpecificMethod() {
    print("This is another useful method.");
  }
}
