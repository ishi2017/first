import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/provider/products.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_grid.dart';
import '../widgets/badge.dart';
import '../provider/cart.dart';
import '../screens/cart_scree.dart';
import '../provider/user_profile.dart';
import '../screens/seller_screen.dart';

enum filters { Favourite, All }

class ProductOverviewScreen extends StatefulWidget {
 
  static String RouteName = '/product_overview';
  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  String _name = '';

  @override
  void initState() {
    Provider.of<User>(context, listen: false).getUserProfile().then((value) {
      setState(() {
        _name = value.name;
      });

    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  bool _isFav = false;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome:' + _name),
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
      body: FutureBuilder(
        future: Provider.of<Products>(context, listen: false).fetchData(),
        builder: (cntx, snap) => snap.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : ProductGrid(
                isFav: _isFav,
              ),
      ),
    );
  }
}
