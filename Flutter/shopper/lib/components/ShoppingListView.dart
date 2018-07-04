import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/components/GlobalState.dart';
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
  List<ShoppingListItem> _items = [];


  refresh(String text){

    setState((){
      AnimationController animationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 700));

      if(_items.isEmpty)
         _items = GlobalState.items.map((x)=> new ShoppingListItem(text: x, animationController: animationController,)).toList();

      animationController.forward();

      if(text == null)
        return;
      GlobalState.items.insert(0, text);
      ShoppingListItem message = new ShoppingListItem(text: text, animationController: animationController);

      _items.insert(0, message);

      message.animationController.forward();
    });


  }

  @override
  void initState() {

    GlobalState.composingChanged.add((x)=>_refresh());
    refresh(null);
    super.initState();
  }

  void _refresh(){
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final padding = new EdgeInsets.all(8.0);

    final listView = new ListView.builder(
      itemBuilder: _itemBuilder,
      padding: padding,
      reverse: true,
      itemCount: _items.length,);

    return GlobalState.isComposing ? new Container(height: 40.0,) : new Flexible(child: listView,);
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