import 'package:flutter/material.dart';
import 'package:shopper/components/NavigationIconView.dart';
import 'package:shopper/screens/CouponsTab.dart';
import 'package:shopper/screens/ReceiptsTab.dart';
import 'package:shopper/screens/SharingTab.dart';
import 'package:shopper/screens/ShoppingListTab.dart';
import 'package:shopper/screens/StoresSetupTab.dart';
import 'package:shopper/styles/CustomIcon.dart';

class TabContainerScreen extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';

  @override
  TabContainerScreenState createState() => new TabContainerScreenState();
}

class TabContainerScreenState extends State<TabContainerScreen>
    with TickerProviderStateMixin {

  int _index = 0;
  BottomNavigationBarType _barType = BottomNavigationBarType.shifting;
  List<NavigationIconView> _navigationIcons;

  // INIT STATE //

  @override
  void initState() {
    super.initState();
    _navigationIcons = _getNavigationIcons();
    _addAnimationListeners();
    _setInitialAnimationValue();
  }

  // -- NAV ICON VIEWS  //

  List<NavigationIconView> _getNavigationIcons(){
    return <NavigationIconView>[_shoppingListTab(), _getBoxIconView(), _getCloudIconView(), _getFavoritesIconView(), _getEventIconView()];
  }

  NavigationIconView _shoppingListTab(){
    final alarmIcon = const Icon(Icons.shop);
    final alarm = new NavigationIconView(icon: alarmIcon, title: 'Today', color: Colors.lime, vsync: this, targetPage: new ShoppingListTab());
    return alarm;
  }

  NavigationIconView _getCloudIconView(){
    //Cloud Page will always use theme color
    final cloudIcon = const Icon(Icons.cloud);
    final cloudTitle = 'Cloud';
    final cloudPage = new CloudPage(title: cloudTitle, icon: cloudIcon,);
    final cloud = new NavigationIconView(icon: cloudIcon, title: cloudTitle, color: Colors.teal, vsync: this, targetPage: cloudPage);
    return cloud;
  }

  NavigationIconView _getBoxIconView(){

    final boxIcon = new CustomIcon();

    //Box will use the navBar color always
    final boxTitle = 'Box';
    final boxColor = Colors.deepOrange;
    final boxPage = new BoxPage(title: boxTitle, icon: boxIcon, color: boxColor);

    final box = new NavigationIconView(icon: boxIcon, title: boxTitle, color: boxColor, vsync: this, targetPage: boxPage);
    return box;

  }

  NavigationIconView _getFavoritesIconView(){
    final favIcon = const Icon(Icons.favorite);
    //Fav Page will use navBar Color if barType is shifting, otherwise use theme accent color
    final favTitle = 'Favorite';
    final favColor = Colors.indigo;
    final favBuilder = (type)=> new FavoritePage(title: favTitle, icon: favIcon, barType:  type, color: favColor);

    final favorites = new NavigationIconView(icon: favIcon, title: 'Favorites', color: favColor, vsync: this, targetPageBuilder: favBuilder);
    return favorites;
  }

  NavigationIconView _getEventIconView(){
    final eventIcon = new Icon(Icons.event);
    final event = new NavigationIconView(icon: eventIcon, title: 'Event', color: Colors.pink, vsync: this, targetPage: new EventPage());
    return event;
  }

  // -- /NAV ICON VIEWS  //

  void _addAnimationListeners(){
    for (NavigationIconView view in _navigationIcons)
      view.animationController.addListener(_refresh);
  }

  void _setInitialAnimationValue(){
    _navigationIcons[_index].animationController.value = 1.0;
  }

  void _refresh() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  // DISPOSE //

  @override
  void dispose() {
    _disposeAnimationControllers();
    super.dispose();
  }

  void _disposeAnimationControllers(){
    for (NavigationIconView view in _navigationIcons)
      view.animationController.dispose();
  }

  // BUILD //

  @override
  Widget build(BuildContext context) {
    return new Scaffold(bottomNavigationBar: _getBottomNavigationBar(), body: _getBody(),);
  }

  // -- BOTTOM NAV BAR //

  BottomNavigationBar _getBottomNavigationBar(){
    final List<BottomNavigationBarItem> barItems = _navigationIcons.map((x)=>x.getBarItem()).toList();
    return new BottomNavigationBar(items: barItems, currentIndex: _index, type: _barType, onTap: _onNavBarTapped);
  }

  NavigationIconView _getCurrentIcon(){
    return _navigationIcons[_index];
  }

  void _onNavBarTapped(int index){
    setState(() {
      _getCurrentIcon().animationController.reverse();
      _index = index;
      _getCurrentIcon().animationController.forward();
    });
  }

  // -- BODY //

  Widget _getBody() {
    final stack = new Stack(children: _pages());
    return new Center(child: stack,);
    // return _getCurrentIcon().targetPage;
  }

  _pages(){
    return NavigationIconView.getPages(_navigationIcons, _barType, context);
  }


}