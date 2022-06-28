import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productID;
  final String title;
  final double price;
  final int quantity;

  const CartItem({
    Key key,
    this.id,
    this.title,
    this.price,
    this.quantity,
    this.productID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Colors.yellow,
        margin: EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: Icon(
          Icons.delete,
          color: Colors.red,
          size: 40,
        ),
        alignment: Alignment.centerRight,
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (cntx) => AlertDialog(
            title: Text('Are you sure'),
            content: Text('Do you want to delete the Item ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(cntx).pop(true);
                },
                child: Text('Yes'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(cntx).pop(false);
                },
                child: Text('No'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productID);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 40.0,
              child: FittedBox(
                child: Text('${price}'),
              ),
            ),
            title: Text('${title}'),
            subtitle: Text('Total ${price * quantity}'),
            trailing: Text('${quantity}x'),
          ),
        ),
      ),
    );
  }
}
