import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../provider/cart.dart';
import '../provider/user_profile.dart';
import 'package:http/http.dart' as http;
import '../models/delivery_status.dart';

class OrderItem {
  String deliveryStatus;
  String userName;
  String mobileNo;
  String Address;
  String id;
  double amount;
  DateTime orderDate;
  List<CartItem> cartProducts;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.cartProducts,
      @required this.orderDate,
      this.userName = '',
      this.mobileNo = '',
      this.Address = '',
      this.deliveryStatus = 'NotDelivered'});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  String token;
  String userId;
  Orders(this.token, this.userId, this._orders);

  Future<List<OrderItem>> fetchforSeller() async {
    List<OrderItem> loadedOrders = [];
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order.json?auth=${token}');
    final response = await http.get(url);
    final extractData = json.decode(response.body) as Map<String, dynamic>;

    for (Map<String, dynamic> eachUsersOrders in extractData.values) {
      for (var eachOrder in eachUsersOrders.values) {
        if (eachOrder['status'] == 'NotDelivered') {
          loadedOrders.add(
            OrderItem(
              deliveryStatus: eachOrder['status'],
              id: eachOrder['creatorId'],
              userName: eachOrder['userName'],
              mobileNo: eachOrder['mobileNo'],
              Address: eachOrder['address'],
              amount: eachOrder['amount'],
              orderDate: DateTime.parse(eachOrder['orderDate']),
              cartProducts: (eachOrder['cartProducts'] as List<dynamic>)
                  .map((cp) => CartItem(
                        id: cp['id'],
                        title: cp['title'],
                        Quantity: cp['quantity'],
                        price: cp['price'],
                      ))
                  .toList(),
            ),
          );
        }
      }
    }
    for (var v in loadedOrders) {
      print(v.amount);
    }
    return loadedOrders;
  }

  Future<void> changeOrderStatus(
      {String newStatus, String forUserId, String OrderDate}) async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order/$forUserId.json?auth=${token}');
    final response = await http.get(url);

    final extractData = json.decode(response.body) as Map<String, dynamic>;
    for (var data in extractData.entries) {
      if (data.value['orderDate'] == OrderDate) {
        final orderURL = Uri.parse(
            'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order/$forUserId/${data.key}.json?auth=${token}');
        final response = await http.patch(orderURL,
            body: json.encode({'status': newStatus}));
      } else {
        print(false);
      }
      notifyListeners();
    }
  }

  Future<void> fetchAndSet() async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order/$userId.json?auth=${token}');
    final response = await http.get(url);

    final extractData = json.decode(response.body) as Map<String, dynamic>;
    if (extractData == null) {
      _orders = [];
      return;
    }

    List<OrderItem> loadedOrders = [];
    extractData.forEach((orderID, orderData) {
      loadedOrders.add(
        OrderItem(
          deliveryStatus: orderData['status'],
          id: orderID,
          userName: orderData['userName'],
          mobileNo: orderData['mobileNo'],
          Address: orderData['address'],
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

  Future<void> addOrders(
      List<CartItem> cartItems, double total, UserProfile profile) async {
    final timeStamp = DateTime.now();
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/order/$userId.json?auth=${token}');

    final responce = await http.post(
      url,
      body: json.encode(
        {
          'status': 'NotDelivered',
          'userName': profile.name,
          'mobileNo': profile.mobileNo,
          'address': profile.Address,
          'creatorId': userId,
          'amount': total,
          'orderDate': timeStamp.toIso8601String(),
          'cartProducts': cartItems
              .map(
                (cp) => {
                  'id': cp.id,
                  'price': cp.price,
                  'quantity': cp.Quantity,
                  'title': cp.title
                },
              )
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
          amount: total,
          userName: profile.name,
          mobileNo: profile.mobileNo,
          Address: profile.Address,
        ));
    notifyListeners();
  }
}
