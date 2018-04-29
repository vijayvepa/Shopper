// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

typedef Widget TargetPageBuilder(BottomNavigationBarType type);

class NavigationIconView {

  final AnimationController animationController;

  final Widget icon;
  final Color color;
  final String title;
  final TickerProvider vsync;

  final Widget targetPage;
  final TargetPageBuilder targetPageBuilder;

  CurvedAnimation _animation;

  NavigationIconView({this.icon, this.title, this.color, this.vsync, this.targetPage, this.targetPageBuilder}):
        animationController = _getAnimationController(vsync)
  {
    final interval = const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn);
    _animation = new CurvedAnimation(  parent: this.animationController, curve: interval);

  }

  static AnimationController _getAnimationController(TickerProvider vsync){
    return new AnimationController( duration: kThemeAnimationDuration, vsync: vsync, );
  }

  // GET BAR ITEM //

  BottomNavigationBarItem getBarItem(){
    return new BottomNavigationBarItem(  icon: this.icon, title: new Text(this.title), backgroundColor: this.color, );
  }

  // GET BODY //

  Widget getPage(BottomNavigationBarType type, BuildContext context) {
    return new FadeTransition( opacity: _animation, child: _getSlideTransition(type) );
  }

  static List<Widget> getPages(List<NavigationIconView> icons, BottomNavigationBarType barType, BuildContext context){
    final List<Widget> pages = icons.map((x)=>x.getPage(barType, context)).toList();
    //stack will paint first child at the bottom, sorting the transitions pushes the oldest to the bottom;
    pages.cast<FadeTransition>().sort(_byOpacity);

    return pages;
  }

  static int _byOpacity(FadeTransition a, FadeTransition b){
    // We want to have the newly animating (fading in) views on top.
    final Animation<double> aAnimation = a.opacity;
    final Animation<double> bAnimation = b.opacity;
    final double aValue = aAnimation.value;
    final double bValue = bAnimation.value;
    return aValue.compareTo(bValue);
  }


  Widget _getSlideTransition(BottomNavigationBarType type){
    const slightlyDown = const Offset(0.0, 0.02);
    final slightlyDownToCurrent = new Tween<Offset>(begin: slightlyDown, end:Offset.zero).animate(_animation);
    return new SlideTransition(child: targetPage ?? targetPageBuilder(type), position: slightlyDownToCurrent);
  }


}

