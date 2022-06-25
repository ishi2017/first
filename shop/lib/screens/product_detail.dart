import 'package:flutter/material.dart';
import '../models/product.dart';
import '../database/data.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = 'product-detail';

  const ProductDetail({Key key}) : super(key: key);

  Product product(String id) {
    final value = loadedProducts.where((element) => element.id == id);
    return value.first;
  }

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;
    print('The id is ${id}');
    return Scaffold(
      appBar: AppBar(
        title: Text(product(id).title),
      ),
      body: Container(
        child: Image.network(
          product(id).imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
