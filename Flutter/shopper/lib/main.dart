import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/ShoppingListTab.dart';
import 'package:shopper/screens/TabContainerScreen.dart';
import 'package:shopper/styles/Themes.dart';

void main(){
  runApp(new FriendlyChatApp());
}


class FriendlyChatApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {


    final theme = defaultTargetPlatform == TargetPlatform.iOS ? Themes.iOS : Themes.android;
    return new MaterialApp(title: "Friendly Chat", theme: theme, home: new TabContainerScreen(),);
  }

}


