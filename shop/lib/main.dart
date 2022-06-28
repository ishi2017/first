import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../screens/product_detail.dart';
import '../screens/product_overview_screen.dart';
import '../widgets/product_item.dart';
import './provider/products.dart';
import './provider/cart.dart';
import './screens/cart_scree.dart';
import './provider/order.dart';
import './screens/order_screen.dart';
import './screens/edit_product_screen.dart';
import '../screens/user_product_screen.dart';

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        )
      ],
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
          ProductDetail.routeName: (context) => ProductDetail(),
          CartScreen.RouteName: (context) => CartScreen(),
          OrderedItems.RouteName: (context) => OrderedItems(),
          UserProductScreen.RouteName: (context) => UserProductScreen(),
          EditProductScreen.RouteName: (context) => EditProductScreen(),
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
