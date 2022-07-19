import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/product_management.dart';
import '../screens/edit_product_screen.dart';
import '../models/product.dart';
import '../provider/auth.dart';

class UserProductScreen extends StatelessWidget {
  static String RouteName = '/userProductScreen';
  const UserProductScreen({Key key}) : super(key: key);

  Future<void> _refresh(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Management'),
        actions: [
          if (!Provider.of<Auth>(context, listen: false)
              .email
              .contains('sales@gmail.com'))
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.RouteName);
                },
                icon: Icon(Icons.add)),
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refresh(context),
        builder: (cntx, snapShotData) =>
            snapShotData.connectionState == ConnectionState.waiting
                ? CircularProgressIndicator()
                : RefreshIndicator(
                    onRefresh: (() => _refresh(context)),
                    child: Consumer<Products>(
                      builder: (cntx, productData, _) => ListView.builder(
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
                    ),
                  ),
      ),
    );
  }
}
