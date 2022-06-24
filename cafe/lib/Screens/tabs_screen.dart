import 'package:flutter/material.dart';
import './categories_screen.dart';
import 'favourit_screen.dart';
import '../Widgets/main_drawer.dart';
import '../Models/meals.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeal;
  const TabsScreen({Key key, this.favMeal}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _Page;

  @override
  void initState() {
    _Page = [
      {'page': CategoriesScreen(), 'title': 'Meal Categories'},
      {
        'page': FavouritScreen(favMeal: widget.favMeal),
        'title': 'Favourit Categories'
      }
    ];

    super.initState();
  }

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
      drawer: MainDrawer(),
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
