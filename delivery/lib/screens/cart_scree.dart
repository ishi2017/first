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
                OrderNow(cart: cart),
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

class OrderNow extends StatefulWidget {
  const OrderNow({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderNow> createState() => _OrderNowState();
}

class _OrderNowState extends State<OrderNow> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: isLoading
          ? CircularProgressIndicator()
          : Text(
              'Order Now',
              style: Theme.of(context).textTheme.bodyText1,
            ),
      onPressed: (widget.cart.totalAmount <= 0)
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false).addOrders(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                isLoading = false;
              });
              widget.cart.clearCart();
            },
    );
  }
}
