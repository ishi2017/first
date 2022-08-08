import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  void Function(String _userEmail, String _userPassword, String _userName,
      bool _isLogin, BuildContext ctx) _submitFn;
  bool isLoading;
  AuthForm(this._submitFn, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  var _isLogin = true;

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();

    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      //Now send values to firebase for authentcation
      widget._submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Invalid Email ID';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Min Length is Four';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(labelText: 'User Name'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('pass'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Min Length is seven';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                        onPressed: _trySubmit,
                        child: Text(_isLogin ? 'Login' : 'Sign Up')),
                  //ElevatedButton(onPressed: () {}, child: Text('Login')),

                  TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                          widget.isLoading = !widget.isLoading;
                        });
                      },
                      child: Text(_isLogin ? 'Sign Up' : 'Login')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
