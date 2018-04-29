import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/components/ChatComposer.dart';
import 'package:shopper/components/ShoppingListView.dart';
import 'package:shopper/content/Strings.dart';


class EventPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final text = new Text('this is event page');
    return new Center(child:text);
  }
}

class ShoppingListTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: _getBody(context),);
  }

  AppBar _getAppBar(BuildContext context) {
    var title = new Text("Shopping List");
    final elevation = Theme.of(context).platform == TargetPlatform.iOS ? 4.0 : 9.0;
    return new AppBar(title: title, elevation: elevation,);
  }

  Widget _getBody(BuildContext context){
    final listView = new ShoppingListView();
    final chatComposer = new ChatComposer(textSubmitted: (x) => _onSubmit(listView, x));
    final divider = new Divider(height: 1.0);

    final column =  new Column(children: <Widget>[listView, divider, chatComposer],);

    final top = new BorderSide(color: Colors.grey[200]);
    final border = new Border(top: top);
    final boxDecoration = new BoxDecoration(border: border);

    final themeBoxDecoration = Theme.of(context).platform == TargetPlatform.iOS ? boxDecoration : null;

    return new Container(decoration: themeBoxDecoration, child: column,);
  }

  void _onSubmit(ShoppingListView view, String text){
    view.addMessage(text);
  }
}