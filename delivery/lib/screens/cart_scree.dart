import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart' show Cart;
import '../screens/cart_item_screen.dart' as ci;
import '../provider/order.dart';
import '../provider/user_profile.dart';
import '../provider/message.dart';

class CartScreen extends StatelessWidget {
  static String RouteName = '/CardScreen';

  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserProfile userInfo = UserProfile(name: '', mobileNo: '', Address: '');
    final cart = Provider.of<Cart>(context);
    Provider.of<User>(context).getUserProfile().then((value) {
      userInfo.name = value.name;
      userInfo.mobileNo = value.mobileNo;
      userInfo.Address = value.Address;
    });

    return Scaffold(
      appBar: AppBar(title: Text('Swipe left to discard items from Cart')),
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
                OrderNow(cart: cart, user: userInfo),
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
    @required this.user,
  }) : super(key: key);

  final Cart cart;
  final UserProfile user;

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
              double minPrice = double.parse(
                  Provider.of<MyAdd>(context, listen: false)
                      .MyMessage
                      .minPrice);
              if (widget.cart.totalAmount < minPrice) {
                _showMinOrderRequired(context, minPrice);
                return;
              }
              setState(() {
                isLoading = true;
              });

              await Provider.of<Orders>(context, listen: false).addOrders(
                  widget.cart.items.values.toList(),
                  widget.cart.totalAmount,
                  widget.user);
              setState(() {
                isLoading = false;
              });
              widget.cart.clearCart();
            },
    );
  }
}

void _showMinOrderRequired(BuildContext context, double value) async {
  await showDialog(
    context: context,
    builder: (cntx) => AlertDialog(
      title: Text(
        'Minimum Order Value ?',
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      content: Text("Minimum Rs. ${value} Order is Required ?"),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(cntx).pop(), child: Text('Okay'))
      ],
    ),
  );
}
