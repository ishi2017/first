import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail.dart';
import '../models/product.dart';
import '../provider/cart.dart';

class ProductItems extends StatelessWidget {
  static String routeName = '/product-item';

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(
      context,
      listen: false,
    );

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetail.routeName, arguments: product.id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            leading: Consumer<Product>(
              builder: (_, product, __) => IconButton(
                icon: product.isFavorite
                    ? Icon(
                        Icons.favorite,
                        color: Theme.of(context).textTheme.bodyText2.color,
                        size: 30.0,
                      )
                    : Icon(
                        Icons.favorite_border,
                        color: Theme.of(context).textTheme.bodyText2.color,
                        size: 22,
                      ),
                onPressed: () {
                  product.toggleFavourite();
                },
              ),
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
              onPressed: () {
                cart.addItem(product.id, product.price, product.title);
                Scaffold.of(context).hideCurrentSnackBar();
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added Item to the Cart'),
                    duration: Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
