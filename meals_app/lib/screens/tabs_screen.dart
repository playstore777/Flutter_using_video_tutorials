import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': CategoriesScreen(), 'title': 'Categories'},
    {'page': FavoriteScreen(), 'title': 'Favorites'}
  ];
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPageIndex]['title']),
        //   bottom: TabBar(
        //     tabs: [
        //       Tab(
        //         icon: Icon(Icons.category),
        //         text: 'Categories',
        //       ),
        //       Tab(
        //         icon: Icon(Icons.star),
        //         text: 'Favorites',
        //       ),
        //     ],
        //   ),
        // ),
        // body: TabBarView(
        //   children: <Widget>[
        //     CategoriesScreen(),
        //     FavoriteScreen(),
        //   ],
        // ),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.shifting,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
