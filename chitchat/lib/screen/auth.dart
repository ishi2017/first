import 'package:flutter/material.dart';
import '../widgets/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  void _submit(
    String _userEmail,
    String _userPassword,
    String _userName,
    bool _isLogin,
  ) {
    print(_userEmail);
    print(_userName);
    print(_userPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submit),
    );
  }
}
