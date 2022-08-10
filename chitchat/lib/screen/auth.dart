import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  void _submit(
    String _userEmail,
    String _userPassword,
    String _userName,
    File profileImg,
    bool _isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (_isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );
        print(authResult.user.email);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: _userEmail,
          password: _userPassword,
        );
        final ref = FirebaseStorage.instance
            .ref()
            .child('User_Images')
            .child('${authResult.user.uid}.jpg');
        await ref.putFile(profileImg);
        FirebaseFirestore.instance
            .collection('user')
            .doc(authResult.user.uid)
            .set({
          'username': _userName,
          'email': _userEmail,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An Error Occured';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(err.message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submit, _isLoading),
    );
  }
}
