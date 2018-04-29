import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/components/ShoppingListItem.dart';

class ShoppingListView extends StatefulWidget{

  final ShoppingListState _chatMessagesState = new ShoppingListState();
  @override
  State createState() => _chatMessagesState;

  addMessage(String text){
    _chatMessagesState.refresh(text);
  }
}

class ShoppingListState extends State<ShoppingListView> with TickerProviderStateMixin{
  final List<ShoppingListItem> _items = [];

  refresh(String text){
    final animationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 700));
    ShoppingListItem message = new ShoppingListItem(text: text, animationController: animationController);

    setState((){
      _items.insert(0, message);
    });

    message.animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final padding = new EdgeInsets.all(8.0);

    final listView = new ListView.builder(
      itemBuilder: _itemBuilder,
      padding: padding,
      reverse: true,
      itemCount: _items.length,);

    return new Flexible(child: listView,);
  }

  ShoppingListItem _itemBuilder(_, int index){
    return _items[index];
  }

  @override
  void dispose(){
    for(ShoppingListItem message in _items){
      message.animationController.dispose();
    }
    super.dispose();
  }

}