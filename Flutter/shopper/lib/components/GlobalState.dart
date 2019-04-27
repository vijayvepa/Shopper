import 'package:flutter/material.dart';
import 'package:shopper/components/ShoppingListItem.dart';

class GlobalState
{
  static bool _isComposing = false;

  static bool disposed;
  static void _composingHasChanged(){
    if(disposed)
      return;
    if(GlobalState.composingChanged.length > 0) {
      for(var item in composingChanged){
        item(_isComposing);
      }
    }
  }

  static bool get isComposing{return _isComposing;}
  static set isComposing(bool value){
    _isComposing = value;
    _composingHasChanged();
  }
  static List<ValueChanged<bool>> composingChanged = new List<ValueChanged<bool>>();

  static List<String> items = [];

}