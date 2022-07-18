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

  Future<bool> isProfileExist() async {
    final URL = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/userProfile/${userId}.json?auth=${token}');
    final response = await http.get(URL);
    if (json.decode(response.body) == null) {
      return false;
    }

    return true;
  }

  Future<UserProfile> getUserProfile() async {
    UserProfile extractedProfile;
    final URL = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/userProfile/${userId}.json?auth=${token}');
    final response = await http.get(URL);
    if (json.decode(response.body) == null) {
      return UserProfile(name: '', mobileNo: '', Address: '');
    }

    final extractUserInfo = json.decode(response.body) as Map<String, dynamic>;
    // for (dynamic profile in extractUserInfo.values) {
    //   extractedProfile = UserProfile(
    //     name: profile['name'],
    //     mobileNo: profile['mobileNo'],
    //     Address: profile['Address'],
    //   );
    // }

    extractUserInfo.forEach((id, profile) {
      extractedProfile = UserProfile(
        userID: id,
        name: profile['name'],
        mobileNo: profile['mobileNo'],
        Address: profile['Address'],
      );
    });

    return extractedProfile;
  }

  Future<void> updateProfile({String userId, UserProfile profile}) async {
    final URL = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/userProfile/${userId}/${profile.userID}.json?auth=${token}');

    final response = await http.put(URL,
        body: json.encode({
          'name': profile.name,
          'mobileNo': profile.mobileNo,
          'Address': profile.Address,
        }));
  }

  Future<void> addUserProfile({String userId, UserProfile profile}) async {
    final URL = Uri.parse(
        'https://testing-e346e-default-rtdb.asia-southeast1.firebasedatabase.app/userProfile/${userId}.json?auth=${token}');
    try {
      final response = await http.post(URL,
          body: json.encode({
            'name': profile.name,
            'mobileNo': profile.mobileNo,
            'Address': profile.Address,
          }));
      if (response.statusCode >= 400) {
        throw HttpException(
            "Error from Firebase" + response.statusCode.toString());
      }
    } catch (error) {
      throw error;
    }
  }
}
