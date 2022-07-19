import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';

class ProductDetail extends StatelessWidget {
  static String routeName = 'product-detail';

  const ProductDetail({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments as String;

    final loadedProduct =
        Provider.of<Products>(context, listen: false).items.firstWhere(
              (element) => element.id == id,
            );
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title), //product(id).title),
      ),
      body: Container(
        child: Column(
          children: [
            Stack(
              children: [
                Card(
                  child: Hero(
                    tag: loadedProduct,
                    child: Image.network(
                      loadedProduct.imageUrl,
                      height: 400,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      alignment: Alignment.center,
                      // width: double.infinity,
                      height: 50,
                      color: Colors.black54,
                      child: Text(
                        "Rs. " + loadedProduct.price.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              loadedProduct.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
