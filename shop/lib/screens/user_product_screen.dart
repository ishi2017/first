import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_management.dart';
import '../screens/edit_product_screen.dart';

class UserProductScreen extends StatelessWidget {
  static String RouteName = '/userProductScreen';
  const UserProductScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.RouteName);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: productData.items.length,
        itemBuilder: (context, index) => Column(
          children: [
            ProductManagement(
              id: productData.items[index].id,
              title: productData.items[index].title,
              ImageUrl: productData.items[index].imageUrl,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
