import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(30),
            height: 100,
            width: double.infinity,
            child: Text(
              'Cooking....',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'RobotoCondensed',
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            leading: Icon(Icons.restaurant),
            title: Text(
              'Meals',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.RouteName);
            },
            leading: Icon(Icons.settings),
            title: Text(
              'Filter',
              style: Theme.of(context).textTheme.headline6,
            ),
          )
        ],
      ),
    );
  }
}
