import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget{
  final String title;
  final Widget icon;
  final Color color;
  final BottomNavigationBarType barType;

  FavoritePage({this.icon, this.title, this.color, this.barType});

  Color _getIconColor(BuildContext context){
    if(this.barType == BottomNavigationBarType.shifting)
      return this.color;

    final ThemeData themeData = Theme.of(context);
    return themeData.brightness == Brightness.light ? themeData.primaryColor : themeData.accentColor;
  }

  @override
  Widget build(BuildContext context) {
    final color = _getIconColor(context);
    return new Center(child:_getColumn(color));
  }

  Widget _getColumn(Color color){
    final title = 'This is the ${this.title} page';
    final text = new Text(title, style: new TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 18.0),);
    return new Column(children: <Widget>[_getIconTheme(color), text], mainAxisAlignment: MainAxisAlignment.center,);
  }

  Widget _getIconTheme(Color iconColor){

    final iconThemeData = new IconThemeData(color: iconColor, size: 250.0);

    final labelPlaceholder = 'Placeholder for $title tab';
    final semantics = new Semantics(label: labelPlaceholder, child: this.icon);

    return new IconTheme(data: iconThemeData, child: semantics,);
  }
}
