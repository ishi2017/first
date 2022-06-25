import 'package:flutter/material.dart';
import '../screens/product_detail.dart';
import '../database/data.dart';
import '../models/product.dart';

class ProductItems extends StatelessWidget {
  static String routeName = '/product-item';

  final String id;
  const ProductItems({Key key, this.id}) : super(key: key);

  Product get product {
    final value = loadedProducts.where((element) => element.id == id);
    return value.first;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetail.routeName, arguments: id);
        },
        child: GridTile(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            backgroundColor: Theme.of(context).primaryColorLight,
            leading: IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).textTheme.bodyText2.color,
              ),
              onPressed: () {},
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
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
