import 'package:flutter/material.dart';

class BoxPage extends StatelessWidget{

  final String title;
  final Widget icon;
  final Color color;

  BoxPage({this.title, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return new Center(child:_getColumn());
  }

  Widget _getColumn(){
    final title = 'You chose ${this.title}';
    final text = new Text(title, style: new TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18.0),);
    return new Column(children: <Widget>[_getIconTheme(), text], mainAxisAlignment: MainAxisAlignment.center,);
  }

  Widget _getIconTheme(){
    final iconThemeData = new IconThemeData(color: color, size: 250.0);

    final labelPlaceholder = 'Placeholder for $title tab';
    final semantics = new Semantics(label: labelPlaceholder, child: this.icon);

    return new IconTheme(data: iconThemeData, child: semantics,);
  }
}
