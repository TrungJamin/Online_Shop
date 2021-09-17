import 'package:flutter/material.dart';
import 'package:online_shop_udemy/consts/my_icons.dart';
import 'package:online_shop_udemy/screens/cart/cart.dart';
import 'package:online_shop_udemy/screens/feeds/feeds.dart';
import 'package:online_shop_udemy/screens/home/home.dart';
import 'package:online_shop_udemy/screens/search/search.dart';
import 'package:online_shop_udemy/screens/user/user.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarNavigation';
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  late List<Map<String, Object>> _screens;
  late int _selectedIndex = 0;

  void _selectedScreen(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _screens = [
      {'screen': HomeScreen(), 'title': 'Home Screen'},
      {'screen': FeedsScreen(), 'title': 'Feeds screen'},
      {'screen': SearchScreen(), 'title': 'Search Screen'},
      {'screen': CartScreen(), 'title': 'CartScreen'},
      {'screen': UserScreen(), 'title': 'UserScreen'}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        centerTitle: true,
//        title: Text(_screens[_selectedIndex]["title"] as String),
//      ),
      body: _screens[_selectedIndex]["screen"] as Widget,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        clipBehavior: Clip.antiAlias,
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.5),
            ),
          ),
          child: _bottomNavigationBar(
            currentIndex: _selectedIndex,
            onSelectedTab: _selectedScreen,
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple,
        tooltip: 'Search',
        elevation: 5,
        child: (Icon(MyIcons.search)),
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
      ),
    );
  }

  BottomNavigationBar _bottomNavigationBar({currentIndex, onSelectedTab}) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).primaryColor,
      unselectedItemColor: Theme.of(context).textSelectionColor,
      selectedItemColor: Colors.purple,
      currentIndex: currentIndex,
      onTap: onSelectedTab,
      items: [
        _buildItem(label: "Home", icon: MyIcons.home),
        _buildItem(label: "Feeds", icon: MyIcons.feeds),
        BottomNavigationBarItem(
          activeIcon: null,
          icon: Icon(null),
          tooltip: "Search",
          label: "Search",
        ),
        _buildItem(label: "Cart", icon: MyIcons.cart),
        _buildItem(label: "User", icon: MyIcons.user),
      ],
    );
  }

  BottomNavigationBarItem _buildItem({label, icon}) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      tooltip: label,
      label: label,
    );
  }
}
