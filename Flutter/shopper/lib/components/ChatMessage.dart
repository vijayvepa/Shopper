import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget{
  static const String _name = "Vijay";

  final String text;
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    final margin = const EdgeInsets.symmetric(vertical: 10.0);
    final container = new Container(margin: margin, child: _getRow(),);
    final curvedAnimation = new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    return new SizeTransition(sizeFactor: curvedAnimation, axisAlignment: 0.0, child: container,);
  }

  Widget _getRow(){
    return new Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[_getAvatar(), _getMessage()],);
  }

  Widget _getAvatar(){
    final nameFirstLetterLabel = new Text(_name[0]);
    final circleAvatar= new CircleAvatar(child: nameFirstLetterLabel);

    final margin = const EdgeInsets.only(right: 16.0);

    return new Container(margin: margin, child: circleAvatar,);
  }

  Widget _getMessage(){
    final column = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[_getFullName(), _getMessageText()],);
    //return column;
    return new Expanded(child: column);
  }

  Widget _getFullName(){
    final subheading = Theme.of(_context).textTheme.subhead;
    return new Text(_name, style: subheading);
  }

  Widget _getMessageText(){
    final label = new Text(text);
    final margin = const EdgeInsets.only(top: 5.0);

    return new Container(margin: margin, child: label,);
  }
}
