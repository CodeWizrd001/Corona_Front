import 'dart:ui';
import 'package:flutter/material.dart';

class Unimplemented extends StatefulWidget {
  @override
  _UnimplementedState createState() => _UnimplementedState();
}

class _UnimplementedState extends State<Unimplemented> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black12,
          body: Center(
            child: Text(
              "Unimplemented Route",
              style: TextStyle(
                fontFamily: "Comic Sans MS",
                fontSize: 25,
                fontWeight: FontWeight.w700 ,
                fontFeatures: <FontFeature>[
                  FontFeature.randomize() ,
                ],
                color: Colors.red,
                shadows: <Shadow>[
                  Shadow(
                    color: Colors.amber,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
