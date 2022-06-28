import 'package:flutter/material.dart';
import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: Column(
        children: [
          AppBar(
            title: Text('Welcome Friend !'),
            automaticallyImplyLeading: false, //It will not add back button here
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text(
              'Shop',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Payments',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrderedItems.RouteName);
            },
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text(
              'Product Management',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductScreen.RouteName);
            },
          ),
        ],
      ),
    );
  }
}
