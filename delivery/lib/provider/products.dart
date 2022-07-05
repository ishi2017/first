import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import '../models/product.dart';
import '../models/http_exception.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];
  String token;
  String userID;
  Products(this.token, this.userID, this._items);

  List<Product> get items {
    return [..._items];
  }

  List<Product> get Fav {
    return _items.where((element) => element.isFavorite).toList();
  }

// &orderBy="crearorId"&equalTo="$userID"'
  Future<void> fetchData([bool filterData = false]) async {
    final filter = filterData ? '&orderBy="creatorId"&equalTo="$userID"' : '';
    var url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=${token}$filter');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<Product> extractedProducts = [];
    if (extractedData == null) {
      return;
    }

    url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/favouriteData/${userID}.json?auth=${token}');
    final favStatusData = await http.get(url);
    final favStatus = json.decode(favStatusData.body);

    extractedData.forEach((productID, ProductData) {
      extractedProducts.add(Product(
          id: productID,
          title: ProductData['title'],
          description: ProductData['description'],
          imageUrl: ProductData['image'],
          price: ProductData['price'],
          isFavorite:
              favStatus == null ? false : favStatus[productID] ?? false));
    });
    _items = extractedProducts;
    notifyListeners();
  }

/* async is used between finction parameter and the opening braces of function. With this
it is ensured that this function has some asynchronous activity and will always return a future. 
There is not need to type return statement in side the function as it will automatically return the future.
Another keyword is await. This keyword is placed before the method/function or any activity whose 
results will come in future. Hree htt.post method will write data to a webserver hence it may take some time
hence its results will come in future. The output of post method is saved in a variable responce. The await also
enforce flutter/dart to wait until the result from awaiting function not received. Hence the next commands
in the programm are invisible for the time being. With await and async it becomes a synchronous code. Hence use 
try-catch-finally a feature of dart to catch the errors.*/
  Future<void> addProduct(Product newProduct) async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/products.json?auth=${token}');

    try {
      final responce = await http.post(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'price': newProduct.price,
            'image': newProduct.imageUrl,
            'creatorId': userID,
          }));

      Product NewProduct = Product(
        id: json.decode(responce.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
        // isFavorite: newProduct.isFavorite,
      );
      _items.add(NewProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error; /*Here it should be noted that the error is not of uture type. but the function has to return 
      a future type. So function will return automaticallt Future(()=>throw error)*/
    }
  }

  Future<void> updateProduct(Product upDatedProduct) async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/products/${upDatedProduct.id}.json?auth=${token}');
    final response = await http.patch(url,
        body: json.encode({
          'title': upDatedProduct.title,
          'description': upDatedProduct.description,
          'price': upDatedProduct.price,
          'image': upDatedProduct.imageUrl,
          // 'fav': upDatedProduct.isFavorite,
        }));
    if (response.statusCode >= 400) {
      throw HttpException('Favourite Status not changed. Try Later!');
    }

    final productIndex =
        _items.indexWhere((element) => element.id == upDatedProduct.id);
    if (productIndex >= 0) {
      _items[productIndex] = upDatedProduct;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/products/${id}.json?auth=${token}');
    final productIndex = _items.indexWhere((element) => element.id == id);
    var product = _items[productIndex];
    _items.removeWhere((element) => element.id == id);

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      _items.insert(productIndex, product);
      notifyListeners();
      throw HttpException('Deletion Failed Try after some time Again !');
    }
    product = null;
    notifyListeners();
  }
}
