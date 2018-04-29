import 'package:flutter/material.dart';

class Themes {

  static final ThemeData iOS = new ThemeData(
      primarySwatch: Colors.orange,
      primaryColor: Colors.lime,
  );

  static final ThemeData android = new ThemeData(
      primarySwatch: Colors.lime,
      accentColor: Colors.orangeAccent[400]
  );

}