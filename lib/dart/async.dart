/*
Asynchronous programming

Synchronous operations block other operations from executing until it completes.

Asynchronous operations let your program complete work (will NOT BLOCK your code, that’s why that function is called asynchronous) 
while waiting for another operation to finish. 

Here are some common asynchronous operations:
  - Fetching data over a network.
  - Writing to a database.

A 'Future' represents the result of an asynchronous operation.  In other words, a Future represents a computation that doesn’t complete immediately. 
When you call a function that returns a future, the function queues up work to be done and returns an uncompleted future.

A Future is like a promise for a result to be provided sometime in the future.

Basically, you can think of Futures as little gift boxes for data. Somebody hands you one of these gift boxes, which starts off closed. 
A little while later the box pops open, and inside there’s either a value or an error.

So, a Future can have two states: uncompleted or completed.
    1   Uncompleted: The gift box is closed.
    2.a Completed with value: The box is open, and your gift (data) is ready.
    2.b Completed with an error: The box is open, but something went wrong. 

Async functions return Futures. Future objects appear throughout the Dart libraries, often as the object returned by an asynchronous method. 
When a future completes, its value is ready to use.

Calling a function that returns a Future, will NOT BLOCK your code, that’s why that function is called asynchronous. 
Instead, it will immediately return a Future object, which is at first uncompleted.

Basic usage

Here’s an example that converts void expensiveWork() from synchronous to asynchronous function:
  1.  First, add the async keyword before the function body.
  2.  If the function has a declared return type, then update the type to be Future<T>, where T is the type of the value that the function returns. 
      If the function doesn’t explicitly return a value, then the return type is Future<void>:

    Future<void> expensiveWork() async { ··· }

Now that you have an async function, you can use the await keyword to wait for a future to complete.

A future of type Future<T> completes with a value of type T. 
For example, a future with type Future<String> produces a String value in the future.

Using await
Before you directly use the Future API, consider using await instead. 
Code that uses await expressions can be easier to understand than code that uses the Future API.

    // Option 1: Using async and await: syntax is like regular sync programming:
    final resp = await http.get(Uri.parse(API_URL));
    var jsonObject = jsonDecode(resp.body);
    final photo = Photo.fromJson(jsonObject);

You can use then() to schedule code that runs when the future completes. 
For example, HttpRequest.getString() returns a Future, since HTTP requests can take a while. 
Using then() lets you run some code when that Future has completed and the promised string value is available:

    // Option 2: Using .then( (T value){} ).catchError( (err){} )
    // Register a callback handler which handles response:
    // callback function's parameter type "T" is the return type of Future<T> http.get() returns a Future<Response> in this example.
    
    http.get(Uri.parse(PHOTO_API_URL))
    .then((response) {
         print("Here is the API response:");
         print(response.body);
    }).catchError((err) {
         print("Caught Error: $err");});


Stream:
-------
Streams provide an asynchronous sequence of data.

Where a Future represents the result of a single computation, a Stream is a sequence of results. 
You listen on a stream to get notified of the results (both data and errors) and of the stream shutting down.

A Stream provides a way to receive a sequence of events. 
Each event is either a data event, also called an element of the stream, or an error event, which is a notification that something has failed.

You can process a stream using either 
  * await for, or 
  * listen() from the Stream API.

On each data event from this stream, the subscriber's onData handler is called.

There are two kinds of streams: "Single-subscription" streams and "broadcast" streams.
A single-subscription stream allows only a single listener during the whole lifetime of the stream. 
It doesn't start generating events until it has a listener, and it stops sending events when the listener is unsubscribed, even if the source of events could still provide more. 
The stream created by an async* function is a single-subscription stream, but each call to the function creates a new such stream.
Listening twice on a single-subscription stream is not allowed, even after the first subscription has been canceled.
Single-subscription streams are generally used for streaming chunks of larger contiguous data, like file I/O.

A broadcast stream allows any number of listeners, and it fires its events when they are ready, whether there are listeners or not.
Broadcast streams are used for independent events/observers.


Generators:
-----------
When you need to lazily produce a sequence of values, consider using a generator function. 
Dart has built-in support for two kinds of generator functions:
  - Synchronous generator: Returns an Iterable object.
  - Asynchronous generator: Returns a Stream object.

To implement a synchronous generator function, mark the function body as sync*, and use yield statements to deliver values:

    Iterable<int> naturalsTo(int n) sync* {
      int k = 0;
      while (k < n) yield k++;
    }
 */

import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../model/person.dart';

final controller = StreamController<int>();
void main(List<String> args) {
  // futureBasics();
  // streamBasics();
  generatorBasics();
}

Future<String> getValue() async {
  print("getValue(): Begin. It will take almost 4 seconds.");

  // simulate a Future that completes after some time using the Future.delayed() constructor:
  await Future.delayed(const Duration(seconds: 4));

  print("getValue(): the value is ready now. Anybody (a)waiting?");
  return 'Here are the long-awaited results ...';
}

Future<int> lengthyComputation(int arg) async {
  print("lengthyComputation(): Begin. It will take almost 8 seconds.");

  // simulate a Future that completes after some time using the Future.delayed() constructor:
  await Future.delayed(const Duration(seconds: 8));

  print("lengthyComputation(): Done, returning the result.");
  return 2 * arg;
}

Future<Person> thingsCanGoWrong({bool returnWithError = false}) async {
  print("thingsCanGoWrong(): Begin. It will take almost 12 seconds.");

  await Future.delayed(const Duration(seconds: 12));
  print("thingsCanGoWrong(): Have been working hard, may return a person soon..");

  if (returnWithError) throw Exception("Ooops");

  return Future.value(Staff("Bar", firstName: "Foo"));
}

void futureBasics() async {
  // When you call an async function that returns a future without 'await',
  // the function queues up work to be done and returns an uncompleted future. (instance of Future)
  // the code does not wait for the completion, moves on with the next line!
  var res = getValue(); // getValue is async, but no await is used here!
  print(
      "The immediate response from the async function which returns a Future: $res"); // Instance of 'Future<String>'

  print("Life goes on ...");

  // Option 1: Using asynch and await
  var calc = await lengthyComputation(10);
  print("The result of lengthyComputation: $calc");

  Person p01 = await thingsCanGoWrong(); // await keyword blocks here.
  print(p01);

  // To handle errors in an async function, use try-catch:
  try {
    Person p02 = await thingsCanGoWrong(returnWithError: true);
    print(p02);
  } catch (e) {
    print('Caught error: $e');
  }

  // Option 2: Using .then( (T value){} ).catchError( (err){} )
  // Lets call an async function, without asigning the result to a variable and await.
  // Instead, call the function and register a callback handler which handles response:
  // callback function's parameter type is "T", which is the return type of Future<T>
  // Note that http.get() returns a Future<Response> in this example.
  http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos/1')).then((response) {
    print("Here is the API response:");
    print(response.body);
  }).catchError((err) {
    print("Caught Error: $err");
  });
}

Stream<int> randStream() async* {
  // 1. use a loop and Future.delayed to create a periodic stream
  //while (true) {
  for (var i = 0; i < 5; i++) {
    yield Random().nextInt(100) + 1; // random number between 1-100
    await Future.delayed(const Duration(seconds: 3));
  }

  // 2. use built-in Stream.periodic method to create a periodic stream
  // return Stream.periodic(const Duration(seconds: 3), (index) => Random().nextInt(100));
}

Stream<String> fruitsStream() async* {
  var fruits = ["Apple", "Banana", "Strawberry", "Orange", "Mango"];

  for (final fruit in fruits) {
    yield fruit;
    await Future.delayed(const Duration(seconds: 1));
  }
}

// modify stream of StreamController in an async manner.
Future<void> updateStream() async {
  for (var i = 0; i < 5; i++) {
    controller.add(i);
    //controller.sink.add(i); // does the same thing internally

    await Future.delayed(const Duration(seconds: 2));

    // the error will be sent over the stream through the sink.
    controller.addError("Error! $i");
  }
  await Future.delayed(Duration(seconds: 5));

  controller.close(); // Close the stream
}

void streamBasics() {
  // Option 1: call your custom Stream function, and .listen() to get StreamSubscription in return.
  // When this function is called, it immediately returns a Stream<T> object.
  // callback function's parameter type is "T", which is the return type of Stream<T>
  // Note that the return type is Stream<int> in this example, so T value is int.
  final numStream = randStream();
  numStream.listen((value) {
    // body of the 'onData' handler
    // On each data event from this stream, the subscriber's onData handler is called.
    print("random number arrived: $value");
  });

  var subs = fruitsStream().where((fruit) => fruit.contains(RegExp('[e-k]'))).listen(
    (element) {
      // body of the 'onData' handler
      // On each data event from this stream, the subscriber's onData handler is called.
      print(element.toUpperCase());
    },
    onDone: () {
      // body of the 'onDone' handler
      print("thats is for fruits stream..");
    },
  );

  print("life goes on..");

  //Option2: listen to the stream controlled by a StreamController
  updateStream();
  var subs2 = controller.stream.listen((event) {
    print(event * 10);
  }, onDone: () {
    print("Numbers stream is done. Bye.");
  }, onError: (e) {
    print("Houston, we have a problem with the stream! $e");
  });
}

// Synchronous generator: Returns an Iterable object.
Iterable<int> numbersUpTo(int n) sync* {
  for (var i = 1; i <= n; i++) {
    yield i;
  }
}

// Asynchronous generator:
//   returns a Stream<T> rather than an Iterable<T>.
//   uses the async* syntax to indicate that it's an asynchronous generator.
//   uses the yield keyword to emit each number, just like the synchronous version.
Stream<int> numbersUpToAsync(int n) async* {
  // int k = 0;
  // while (k < n) yield k++;

  for (var i = 1; i <= n; i++) {
    yield i;
    // simulate a Future that completes after some time using the Future.delayed() constructor:
    await Future.delayed(const Duration(seconds: 2));
  }
}

// it calls an async* generator, so it has async keyword.
void generatorBasics() async {
  final nums = numbersUpTo(5);
  for (var n in nums) {
    print("Generated: $n");
  }

  final nums2 = numbersUpToAsync(5);
  await for (final num in numbersUpToAsync(5)) {
    print("Asynchronous generator: $num");
  }
}
