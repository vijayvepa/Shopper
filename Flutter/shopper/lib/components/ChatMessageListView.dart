import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/components/ChatMessage.dart';

class ChatMessageListView extends StatefulWidget{

  final ChatMessagesState _chatMessagesState = new ChatMessagesState();
  @override
  State createState() => _chatMessagesState;

  addMessage(String text){
    _chatMessagesState.refresh(text);
  }
}

class ChatMessagesState extends State<ChatMessageListView> with TickerProviderStateMixin{
  final List<ChatMessage> _messages = [];

  refresh(String text){
    final animationController = new AnimationController(vsync: this, duration: new Duration(milliseconds: 700));
    ChatMessage message = new ChatMessage(text: text, animationController: animationController);

    setState((){
      _messages.insert(0, message);
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
      itemCount: _messages.length,);

    return new Flexible(child: listView,);
  }

  ChatMessage _itemBuilder(_, int index){
    return _messages[index];
  }

  @override
  void dispose(){
    for(ChatMessage message in _messages){
      message.animationController.dispose();
    }
    super.dispose();
  }

}