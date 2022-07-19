import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../screens/order_screen.dart';
import '../screens/user_product_screen.dart';
import '../screens/client_info_screen.dart';
import '../provider/auth.dart';
import '../provider/user_profile.dart';
import '../provider/message.dart';
import '../screens/msg.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  String msg, url = 'http://www.practice.host/add/image.jpg';

  void setMsg(message newMsg) {
    msg = newMsg.msg;
    url = newMsg.ImageURL;
    Provider.of<MyAdd>(context, listen: false).setAdd(
        msg: msg,
        imgURL: url,
        status: newMsg.active,
        minPrice: newMsg.minPrice);

    setState(() {});
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      Provider.of<MyAdd>(context, listen: false).getAdd().then((value) {
        msg = value.msg;
        url = value.ImageURL;
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              title: Text('Welcome Friend !'),
              automaticallyImplyLeading:
                  false, //It will not add back button here
            ),
            Divider(),
            if (Provider.of<Auth>(context, listen: false)
                .email
                .contains('sales@gmail.com'))
              ListTile(
                leading: Icon(Icons.home, color: Colors.amber),
                title: Text(
                  'Orders',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            Divider(),
            if (!Provider.of<Auth>(context, listen: false)
                .email
                .contains('sales@gmail.com'))
              ListTile(
                leading: Icon(Icons.shop, color: Colors.amber),
                title: Text(
                  'Shopping',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
              ),
            Divider(),
            if (!Provider.of<Auth>(context, listen: false)
                .email
                .contains('sales@gmail.com'))
              ListTile(
                leading: Icon(Icons.payment, color: Colors.amber),
                title: Text(
                  'My Orders',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(OrderedItems.RouteName);
                },
              ),
            if (!Provider.of<Auth>(context, listen: false)
                .email
                .contains('sales@gmail.com'))
              ListTile(
                leading: Icon(Icons.payment, color: Colors.amber),
                title: Text(
                  'Edit User Profile',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Provider.of<User>(context, listen: false)
                      .getUserProfile()
                      .then((userProfile) => Navigator.of(context).pushNamed(
                          ClientInfo.RouteName,
                          arguments: userProfile));
                },
              ),
            if (Provider.of<Auth>(context, listen: false)
                    .email
                    .contains('admin@gmail.com') ||
                Provider.of<Auth>(context, listen: false)
                    .email
                    .contains('sales@gmail.com'))
              ListTile(
                leading: Icon(Icons.payment, color: Colors.amber),
                title: Text(
                  'Product Management',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Provider.of<User>(context, listen: false)
                      .getUserProfile()
                      .then((userProfile) => Navigator.of(context)
                          .pushNamed(UserProductScreen.RouteName));
                },
              ),
            if (Provider.of<Auth>(context, listen: false)
                .email
                .contains('admin@gmail.com'))
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.amber,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Msg.routeName, arguments: setMsg);
                },
              ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.red),
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
            Container(
              height: 350,
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Stack(
                children: [
                  Image.network(
                    url,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        alignment: Alignment.center,
                        // width: double.infinity,
                        height: 200,
                        color: Colors.black,
                        child: Text(
                          msg ?? 'No Message',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.normal),
                          softWrap: true,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
