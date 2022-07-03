import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;

  String get userID {
    return _userId;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<String> _authenticate(
      {String Email, String Password, String urlHost}) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:${urlHost}?key=AIzaSyCoikIG1Z18jb8XEk364Yl-6ip8JR5cBvQ');

    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': Email, 'password': Password, 'returnSecureToken': true},
        ),
      );
      final extractedData = json.decode(response.body);
      if (extractedData['error'] != null) {
        throw HttpException(extractedData['error']['message']);
      }
      _token = extractedData['idToken'];
      _userId = extractedData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(extractedData['expiresIn']),
        ),
      );
      //autiLogOut();
      notifyListeners();
      return extractedData['email'];
    } catch (error) {
      throw error;
    }
  }

  Future<String> signup({String Email, String Password}) async {
    return await _authenticate(
        Email: Email, Password: Password, urlHost: 'signUp');
  }

  Future<String> login({String Email, String Password}) async {
    return await _authenticate(
        Email: Email, Password: Password, urlHost: 'signInWithPassword');
  }

  void logout() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  void autiLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final _duration = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: _duration), logout);
  }
}
