import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopper/components/GlobalState.dart';
import 'package:shopper/content/Strings.dart';


class ChatComposer extends StatefulWidget{
  final ValueChanged<String> textSubmitted;
  ChatComposer({this.textSubmitted});


  @override
  State<StatefulWidget> createState() {
    return new ChatComposerState(textSubmitted: this.textSubmitted);
  }

}

class ChatComposerState extends State<ChatComposer> {

  final ValueChanged<String> textSubmitted;
  FocusNode _focusNode = new FocusNode();

  ChatComposerState({this.textSubmitted});

  final TextEditingController _textEditingController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _focusNode.addListener((){
        if(GlobalState.isComposing)
          return;
        GlobalState.isComposing = _focusNode.hasFocus;
    });
  }
  @override
  Widget build(BuildContext context) {

    final cardColor = Theme.of(context).cardColor;
    final boxDecoration = new BoxDecoration(color: cardColor);

    return new Container(decoration: boxDecoration,  child: _getComposer(),);

  }

  Widget _getComposer(){
    final margin = const EdgeInsets.symmetric(horizontal: 8.0);
    return new Container(margin: margin, child: _getRow(),);
  }

  Widget _getRow(){
    return new Row(children: <Widget>[_getTextField(), _getSendButton()],);
  }

  Widget _getTextField(){

    final decoration = new InputDecoration.collapsed(hintText: Strings.addItem);
    final textfield= new TextField(controller: _textEditingController, onChanged: _handleChange, onSubmitted: _handleSubmitted,
      focusNode: _focusNode, decoration: decoration,);


     return new Flexible(child: textfield);
  }

  Widget _getSendButton(){
    final margin = new EdgeInsets.symmetric(horizontal: 4.0);
    final sendIcon = new Icon(Icons.add_circle);
    final sendText = new Text("Send");
    final cupertinoButton = new CupertinoButton(child: sendText, onPressed: _determineIconButtonAction(),);
    final iconButton = new IconButton(icon: sendIcon, onPressed: _determineIconButtonAction(),);

    final button = iconButton;

    return new Container(margin: margin, child: button,);
  }

  VoidCallback _determineIconButtonAction(){
    return GlobalState.isComposing ? _onIconButtonPressed : null;
  }

  void _onIconButtonPressed(){

    _handleSubmitted(_textEditingController.text);
  }

  void _handleSubmitted(String value){
    if(!GlobalState.isComposing)
      return;

    _textEditingController.clear();
    textSubmitted(value);
    GlobalState.isComposing = false;
  }

  void _handleChange(String value){
    setState((){
      GlobalState.isComposing = value.length > 0;

     });
  }


}
