import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import '../widgets/product_item.dart';
import '../models/product.dart';

class ProductGrid extends StatelessWidget {
  final bool isFav;

  ProductGrid({this.isFav});
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final product = isFav ? productData.Fav : productData.items;
    return GridView.builder(
      padding: EdgeInsets.all(5),
      itemCount: product.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: product[index],
        child: ProductItems(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 5,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 5,
      ),
    );
  }
}
