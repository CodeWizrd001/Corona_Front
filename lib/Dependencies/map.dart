import 'package:flutter/material.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    print("Return Map");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Image.asset('assets/images/WorldMap1.jpg'),
            Text(
              "Unimplemented Route" ,
              style: TextStyle(
                fontWeight: FontWeight.bold ,
                color: Colors.red ,
              ),
            ) ,
          ],
        ),
      ),
    );
  }
}
