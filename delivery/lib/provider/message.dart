import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class message {
  String msg;
  String ImageURL;
  String active;
  String minPrice;

  message({
    this.msg = '',
    this.ImageURL = 'http://www.practice.host/add/image.jpg',
    this.active = 'Active',
    this.minPrice = '100',
  });
}

class MyAdd with ChangeNotifier {
  String token;
  String userId;
  MyAdd(this.token, this.userId);
  final fbKey = 'AIzaSyBS09uRrPhSS6CTOwNiihJgVnztvOv9nDk';

  message MyMessage = message();

  void setAdd(
      {String msg = 'No Message',
      String imgURL = 'http://www.practice.host/add/image.jpg',
      String status = 'Active',
      String minPrice = '100'}) async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/Message.json?auth=${token}');
    try {
      final responce = await http.put(
        url,
        body: json.encode(
          {
            'msg': msg,
            'url': imgURL,
            'status': status,
            'minPrice': minPrice,
          },
        ),
      );
      if (responce.statusCode >= 400) {
        throw HttpException('Some error Arouse');
      }

      MyMessage.msg = msg;
      MyMessage.ImageURL = imgURL;
      MyMessage.active = status;
      MyMessage.minPrice = minPrice;
    } catch (error) {
      throw error;
    }
  }

  Future<message> getAdd() async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/Message.json?auth=${token}');
    final response = await http.get(url);

    final extractData = json.decode(response.body) as Map<String, dynamic>;
    if (extractData == null) {
      return MyMessage;
    }

    MyMessage.msg = extractData['msg'];
    MyMessage.ImageURL = extractData['url'];
    MyMessage.active = extractData['status'];
    MyMessage.minPrice = extractData['minPrice'].toString();
    return MyMessage;
  }
}
