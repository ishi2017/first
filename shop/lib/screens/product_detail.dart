import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = 'product-detail';

  const ProductDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Hello'), //product(id).title),
      ),
      body: Container(
        child: Center(
          child: Text('Hello'),
        ),
        //  Image.network(
        //   product(id).imageUrl,
        //   fit: BoxFit.cover,
        // ),
      ),
    );
  }
}
