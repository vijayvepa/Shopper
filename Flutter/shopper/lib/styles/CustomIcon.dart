import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);

    final margin = const EdgeInsets.all(6.0);
    final size = iconTheme.size - 6.0;

    return new Container( margin: margin, width: size, height: size,  color: iconTheme.color,);
  }
}
