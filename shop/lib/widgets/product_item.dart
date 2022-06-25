import 'package:flutter/material.dart';
import '../screens/product_detail.dart';

class ProductItems extends StatelessWidget {
  static String routeName = '/product-item';

  final String id;
  final String title;
  final String imageUrl;
  const ProductItems({
    Key key,
    this.id,
    this.title,
    this.imageUrl,
  }) : super(key: key);

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
            imageUrl,
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
              title,
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
