import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../provider/cart.dart';
import '../screens/cart_scree.dart';

enum filters { Favourite, All }

class ProductOverviewScreen extends StatefulWidget {
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _isFav = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (selected) {
              setState(() {
                if (selected == filters.Favourite) {
                  _isFav = true;
                } else {
                  _isFav = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Faverouite'),
                value: filters.Favourite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: filters.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              color: Theme.of(context).accentColor,
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: InkWell(
              splashColor: Colors.red,
              borderRadius: BorderRadius.circular(15),
              onTap: () {
                Navigator.of(context).pushNamed(
                  CartScreen.RouteName,
                );
              },
              child: Icon(
                Icons.shopping_cart,
                size: 50,
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ProductGrid(
        isFav: _isFav,
      ),
    );
  }
}
