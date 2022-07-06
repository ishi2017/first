import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';
import '../screens/client_info_screen.dart';
import '../provider/auth.dart';
import '../provider/user_profile.dart';
import '../helpers/custom_route.dart';

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
              'Shopping',
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
              'My Orders',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrderedItems.RouteName);

              // Navigator.of(context).pushReplacement(
              //   CustomRoute(
              //     builder: (cntx) => OrderedItems(),
              //   ),
              // );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.payment),
          //   title: Text(
          //     'User Profile',
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   onTap: () {

          //     Provider.of<User>(context, listen: false)
          //         .isProfileComplete()
          //         .then((value) => print(value));
          //     //Navigator.of(context).pushNamed(ClientInfo.RouteName);
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.black),
            ),
            onTap: () async {
              Navigator.of(context).pop();
              await Provider.of<Auth>(context, listen: false).logout();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
    );
  }
}
