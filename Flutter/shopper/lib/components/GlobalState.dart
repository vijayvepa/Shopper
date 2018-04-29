import 'package:flutter/material.dart';

class GlobalState
{
  static bool _isComposing = false;
  static void _composingHasChanged(){
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

}