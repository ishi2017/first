import 'package:flutter/cupertino.dart';
import '../provider/cart.dart';

class OrderItem {
  String id;
  double amount;
  DateTime orderDate;
  List<CartItem> cartProducts;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.cartProducts,
    @required this.orderDate,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartItems, double total) {
    print(cartItems);
    print(total);
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            orderDate: DateTime.now(),
            cartProducts: cartItems,
            amount: total));
    notifyListeners();
  }
}
