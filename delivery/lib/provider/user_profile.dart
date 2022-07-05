import 'dart:convert';
import 'dart:async';
import 'package:flutter_complete_guide/models/http_exception.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserProfile {
  String userID;
  String name;
  String mobileNo;
  String Address;

  UserProfile({
    this.userID,
    @required this.name,
    @required this.mobileNo,
    @required this.Address,
  });
}

class User with ChangeNotifier {
  final String token;
  final String userId;

  User(this.token, this.userId);

  Future<bool> isProfileComplete() async {
    final URL = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/userProfile/${userId}.json?auth=${token}');
    final response = await http.get(URL);
    if (json.decode(response.body) == null) {
      return false;
    }

    return true;
  }

  Future<void> addUserProfile({String userId, UserProfile profile}) async {
    final URL = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/userProfile/${userId}.json?auth=${token}');

    final response = await http.post(URL,
        body: json.encode({
          'userId': userId,
          'name': profile.name,
          'mobileNo': profile.mobileNo,
          'Address': profile.Address,
        }));

    print(json.decode(response.body));

    // if (response.statusCode > 400) {
    //   print('Error');
    //   throw HttpException('Error Occured Bhai....');
    // }
    // print('Record Saved');
  }

  voidEditUserProfile() {}
}
