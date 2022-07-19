import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './provider/message.dart';
import './screens/seller_screen.dart';
import './screens/client_info_screen.dart';
import './screens/product_detail.dart';
import './screens/product_overview_screen.dart';
import './screens/order_screen.dart';
import './screens/cart_scree.dart';
import './screens/edit_product_screen.dart';
import './screens/user_product_screen.dart';
import './screens/auth_screen.dart';
import './widgets/product_item.dart';
import './provider/auth.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './provider/order.dart';
import './screens/splash_screen.dart';
import './provider/user_profile.dart';
import './helpers/custom_route.dart';
import './screens/msg.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool status = true;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      Provider.of<Auth>(context, listen: false).logout();
      exit(0);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // bool _checkStatus(BuildContext cntx) {
  //   setState(() {
  //     Provider.of<MyAdd>(cntx, listen: false).getAdd().then((value) {
  //       if (value.active.contains('Active')) {
  //         status = true;
  //       } else {
  //         status = false;
  //       }
  //     });

  //     return status;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    //String email = ModalRoute.of(context).settings.arguments as String;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, User>(
          create: (cntx) => User(null, null),
          update: (cntx, auth, previousItem) => User(auth.token, auth.userID),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (context) => Products(null, null, []),
          update: (cnts, auth, previousItem) => Products(
              auth.token,
              auth.userID,
              previousItem.items == null ? [] : previousItem.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (context) => Orders(null, null, []),
          update: (cnts, auth, previousOrders) => Orders(
              auth.token,
              auth.userID,
              previousOrders.orders == null ? [] : previousOrders.orders),
        ),
        ChangeNotifierProxyProvider<Auth, MyAdd>(
            create: (context) => MyAdd(null, null),
            update: (cnts, auth, previousOrders) => MyAdd(
                  auth.token,
                  auth.userID,
                )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
          fontFamily: 'Lato',
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CustomPageTransitionBuilder(),
              TargetPlatform.iOS: CustomPageTransitionBuilder(),
            },
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Lato',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                bodyText2: TextStyle(
                  color: Colors.brown,
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.normal,
                  fontSize: 15,
                ),
                headline6: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Anton',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                button: TextStyle(color: Colors.white),
              ),
        ),

        // home: auth.isAuth ? ProductOverviewScreen() : AuthScreen(),
        initialRoute: '/',
        routes: {
          '/': (cntx) => (Provider.of<Auth>(cntx).isAuth &&
                  Provider.of<Auth>(cntx, listen: false)
                      .email
                      .contains('sales@gmail.com'))
              ? SellerDashBoard()
              : Provider.of<Auth>(cntx).isAuth
                  ? ProductOverviewScreen()
                  : FutureBuilder(
                      future: Provider.of<Auth>(cntx).tryAutoLogin(),
                      builder: (cntx, authResult) =>
                          authResult.connectionState == ConnectionState.waiting
                              ? SplashScreen()
                              : AuthScreen(),
                    ),
          ProductOverviewScreen.RouteName: (cntx) => ProductOverviewScreen(),
          SellerDashBoard.routeName: (cntx) => SellerDashBoard(),
          ProductItems.routeName: (cntx) => ProductItems(),
          ProductDetail.routeName: (cntx) => ProductDetail(),
          CartScreen.RouteName: (cntx) => CartScreen(),
          OrderedItems.RouteName: (cntx) => OrderedItems(),
          UserProductScreen.RouteName: (cntx) => UserProductScreen(),
          EditProductScreen.RouteName: (cntx) => EditProductScreen(),
          ClientInfo.RouteName: (context) => ClientInfo(),
          Msg.routeName: (context) => Msg(),
        },
        onGenerateRoute: (setting) {
          return MaterialPageRoute(
              builder: (context) => ProductOverviewScreen());
        },
        onUnknownRoute: (setting) {
          return MaterialPageRoute(
              builder: (context) => ProductOverviewScreen());
        },
      ),
    );
  }
}
