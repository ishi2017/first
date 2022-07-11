import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  String _userId;
  DateTime _expiryDate;
  Timer _authTimer;
  String _email;

  String get email {
    print(_email);
    return _email;
  }

  int get ExpiryData {
    return _expiryDate.difference(DateTime.now()).inSeconds;
  }

  String get userID {
    return _userId;
  }

  bool get isAuth {
    //logout();
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

  Future<dynamic> _authenticate(
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
      print("Token Generated==>" + _token);
      autoLogOut();
      notifyListeners();
      this._email = extractedData['email'];
      /* We r storing data in device storge */
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'email': _email,
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate.toIso8601String()
      });
      prefs.setString('userData', userData);

      return extractedData;
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _expiryDate = DateTime.parse(extractData['expiryDate']);
    if (_expiryDate.isBefore(DateTime.now())) {
      await autoLogOut();
      return false;
    }
    _token = extractData['token'];
    _userId = extractData['userId'];
    _email = extractData['email'];

    notifyListeners();

    return true;
  }

  Future<dynamic> signup({String Email, String Password}) async {
    return await _authenticate(
        Email: Email, Password: Password, urlHost: 'signUp');
  }

  Future<dynamic> login({String Email, String Password}) async {
    return await _authenticate(
        Email: Email, Password: Password, urlHost: 'signInWithPassword');
  }

  void logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userDate');
    prefs.clear();
  }

  void clearPref() async {
    final prefs = await SharedPreferences.getInstance();
    //prefs.remove('userDate');
    prefs.clear();
  }

  void autoLogOut() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final _duration = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: _duration), logout);
  }
}
