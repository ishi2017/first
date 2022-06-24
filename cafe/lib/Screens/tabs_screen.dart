import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favourit_scree.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _Page = [
    {'page': CategoriesScreen(), 'title': 'Meal Categories'},
    {'page': FavouritScreen(), 'title': 'Favourit Categories'}
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
        title: Text(_Page[_selectedPageIndex]['title']),
      ),
      body: _Page[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        // currentIndex: 1,
        //type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            label: ('Category'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: ('Favourit'),
          ),
        ],
      ),
    );
  }
}
