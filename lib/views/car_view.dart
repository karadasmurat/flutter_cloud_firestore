import 'package:flutter/material.dart';
import 'package:flutter_cloud_firestore/model/car.dart';
import 'package:transparent_image/transparent_image.dart';

class CarPage extends StatelessWidget {
  final Car car;
  const CarPage(this.car, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Details"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            FadeInImage.assetNetwork(
              height: 400,
              fit: BoxFit.fill,
              placeholder: "assets/images/loading.gif",
              image: "https://source.unsplash.com/random/400x400/?car&sig=$car",
            ),
            const SizedBox(height: 20),
            Text(car.make,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                )),
          ],
        ),
      ),
    );
  }
}
