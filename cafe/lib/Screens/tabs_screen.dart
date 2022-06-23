import 'package:flutter/material.dart';
import './categories_screen.dart';
import './favourit_scree.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        initialIndex: 0,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Meal App'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                  icon: Icon(Icons.category),
                  child: Text('Categories'),
                ),
                Tab(
                  icon: Icon(Icons.star),
                  child: Text('Favourit'),
                ),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            CategoriesScreen(),
            FavouritScreen(),
          ]),
        ));
  }
}
