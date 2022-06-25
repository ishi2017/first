import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final product = productData.items;
    return GridView.builder(
      padding: EdgeInsets.all(5),
      itemCount: product.length,
      itemBuilder: (context, index) => ProductItems(
        id: product[index].id,
        title: product[index].title,
        imageUrl: product[index].imageUrl,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 5,
      ),
    );
  }
}
