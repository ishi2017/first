import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/cart_item_screen.dart';

class CartItem {
  final String id;
  final String title;
  final int Quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.Quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, value) {
      total += value.Quantity * value.price;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (ExistingValue) => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          Quantity: ExistingValue.Quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          Quantity: 1,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String productID) {
    _items.remove(productID);
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId].Quantity > 1) {
      _items.update(
          productId,
          (existingProduct) => CartItem(
              id: productId,
              title: existingProduct.title,
              price: existingProduct.price,
              Quantity: existingProduct.Quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
}
