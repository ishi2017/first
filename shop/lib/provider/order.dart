import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../provider/cart.dart';
import 'package:http/http.dart' as http;

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

  String token;
  String userId;
  Orders(this.token, this.userId, this._orders);

  Future<void> fetchAndSet() async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order/$userId.json?auth=${token}');
    final response = await http.get(url);

    final extractData = json.decode(response.body) as Map<String, dynamic>;
    if (extractData == null) {
      return;
    }

    List<OrderItem> loadedOrders = [];
    extractData.forEach((orderID, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderID,
          amount: orderData['amount'],
          orderDate: DateTime.parse(orderData['orderDate']),
          cartProducts: (orderData['cartProducts'] as List<dynamic>)
              .map((cp) => CartItem(
                    id: cp['id'],
                    title: cp['title'],
                    Quantity: cp['quantity'],
                    price: cp['price'],
                  ))
              .toList(),
        ),
      );
    });
    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrders(List<CartItem> cartItems, double total) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order/$userId.json?auth=${token}');

    final responce = await http.post(
      url,
      body: json.encode(
        {
          'amount': total,
          'orderDate': timeStamp.toIso8601String(),
          'cartProducts': cartItems
              .map((cp) => {
                    'id': cp.id,
                    'price': cp.price,
                    'quantity': cp.Quantity,
                    'title': cp.title
                  })
              .toList(),
        },
      ),
    );
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(responce.body)['name'],
            orderDate: timeStamp,
            cartProducts: cartItems,
            amount: total));
    notifyListeners();
  }
}
