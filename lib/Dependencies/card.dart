import 'package:flutter/material.dart';

class MyCard extends StatefulWidget {
  final String name;
  final String roll;
  final int age;

  MyCard({this.name, this.roll, this.age});

  _MyCardState createState() => _MyCardState(name: name, roll: roll, age: age);
}

class _MyCardState extends State<MyCard> {
  String name;
  String roll;
  int age;

  _MyCardState({this.name, this.roll, this.age});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(7.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Text("Hello"),
            ),
            Padding(
              padding: EdgeInsets.all(7.0),
              child: Text("World"),
            ),
          ],
        ),
      ),
    );
  }
}
