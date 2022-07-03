import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavourite(Auth auth) async {
    print(title);
    final oldFavStatus = isFavorite;
    isFavorite = !isFavorite;
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/favouriteData/${auth.userID}/${id}.json?auth=${auth.token}');
    try {
      final response = await http.put(url,
          body: json.encode(
            isFavorite,
          ));
      if (response.statusCode >= 400) {
        _setFavValue(oldFavStatus);
        print(json.decode(response.body));
        throw HttpException('Favourite Status not changed. Try Later!' +
            response.body.toString());
      }
    } catch (e) {
      throw e;
    }

    notifyListeners();
  }
}
