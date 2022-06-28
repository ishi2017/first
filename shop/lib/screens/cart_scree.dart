import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart' show Cart;
import '../screens/cart_item_screen.dart' as ci;
import '../provider/order.dart';

class CartScreen extends StatelessWidget {
  static String RouteName = '/CardScreen';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart Details')),
      body: Column(
        children: [
          Card(
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Amount'),
                Spacer(),
                Chip(
                  label: Text('${cart.totalAmount}'),
                ),
                FlatButton(
                  onPressed: () {
                    Provider.of<Orders>(context, listen: false).addOrders(
                      cart.items.values.toList(),
                      cart.totalAmount,
                    );
                    cart.clearCart();
                  },
                  child: Text(
                    'Place Order',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: ((context, index) => ci.CartItem(
                    productID: cart.items.keys.toList()[index],
                    id: cart.items.values.toList()[index].id,
                    title: cart.items.values.toList()[index].title,
                    price: cart.items.values.toList()[index].price,
                    quantity: cart.items.values.toList()[index].Quantity,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
