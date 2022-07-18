import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class message {
  String msg;
  String ImageURL;

  message({
    this.msg = '',
    this.ImageURL = 'http://www.practice.host/add/image.jpg',
  });
}

class MyAdd with ChangeNotifier {
  String token;
  String userId;
  MyAdd(this.token, this.userId);
  final fbKey = 'AIzaSyCoikIG1Z18jb8XEk364Yl-6ip8JR5cBvQ';

  message MyMessage = message();

  void setAdd({String msg, String imgURL}) async {
    final url = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/Message.json?auth=${token}');
    try {
      final responce = await http.put(
        url,
        body: json.encode(
          {
            'msg': msg,
            'url': imgURL,
          },
        ),
      );
      if (responce.statusCode >= 400) {
        throw HttpException('Some error Arouse');
      }

      MyMessage.msg = msg;
      MyMessage.ImageURL = imgURL;
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

    return MyMessage;
  }
}
