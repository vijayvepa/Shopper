import 'package:flutter/material.dart';

class Themes {

  static final ThemeData iOS = new ThemeData(
      primarySwatch: Colors.orange,
      primaryColor: Colors.grey[100],
      primaryColorBrightness: Brightness.light
  );

  static final ThemeData android = new ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.orangeAccent[400]
  );

}