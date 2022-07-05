import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../provider/products.dart';

class ProductManagement extends StatelessWidget {
  final String ImageUrl;
  final String title;
  final String id;

  const ProductManagement({
    Key key,
    this.id,
    this.title,
    this.ImageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(ImageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 150,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.RouteName, arguments: id);
              }, //This is the mark 1
              icon: Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .removeProduct(id);
                } catch (Error) {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        Error.toString(),
                      ),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: Icon(Icons.delete),
            ),
          ],
        ),
      ),
    );
  }
}
