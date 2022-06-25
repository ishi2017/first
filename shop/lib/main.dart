import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

import '../screens/product_overview_screen.dart';
import '../widgets/product_item.dart';
import './provider/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
          fontFamily: 'Lato',
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
        home: ProductOverviewScreen(),
        // initialRoute: '/',
        routes: {
          // '/': (context) => ProductOverviewScreen(),
          ProductItems.routeName: (context) => ProductItems(),
          ProductDetail.routeName: ((context) => ProductDetail()),
        },
        // onGenerateRoute: (setting) {
        //   return MaterialPageRoute(
        //       builder: (context) => ProductOverviewScreen());
        // },
        // onUnknownRoute: (setting) {
        //   return MaterialPageRoute(
        //       builder: (context) => ProductOverviewScreen());
        // },
      ),
    );
  }
}
