import 'dart:math';

import 'package:flutter/material.dart';

Container buildBackgroundContainer() {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
              Color.fromRGBO(215, 188, 117, 1).withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0,1]
        )
    ),
  );
}

Flexible buildFlexibleContainer(BuildContext context) {
  return Flexible(
    child: Container(
      margin: EdgeInsets.only(bottom: 20),
      padding:
      EdgeInsets.symmetric(vertical: 8, horizontal: 94),
      transform: Matrix4.rotationZ(-8 * pi / 180)
        ..translate(-10.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.deepOrange.shade900,
          boxShadow: [
            BoxShadow(
              blurRadius: 8,
              color: Colors.black26,
              offset: Offset(0, 2),
            )
          ]),
      child: Text(
        "My Shop",
        style: TextStyle(
            color: Theme.of(context)
                .accentTextTheme
                .headline6
                .color,
            fontSize: 50,
            fontFamily: 'Anton'),
      ),
    ),
  );
}