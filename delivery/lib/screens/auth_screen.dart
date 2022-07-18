import 'dart:math';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import './product_overview_screen.dart';
import '../provider/auth.dart';
import '../models/http_exception.dart';
import '../provider/user_profile.dart';
import '../screens/seller_screen.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatelessWidget {
  static const routeName = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                  Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0, 1],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: 75,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          bottom: 50.0, left: 15.0, right: 10.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      // ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      child: Text(
                        'Dwarkadas Grocery Store, Bhusawal',
                        style: TextStyle(
                          color:
                              Theme.of(context).accentTextTheme.headline6.color,
                          fontSize: 20,
                          fontFamily: 'Anton',
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: deviceSize.width > 600 ? 2 : 1,
                    child: AuthCard(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthCard extends StatefulWidget {
  const AuthCard({
    Key key,
  }) : super(key: key);

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  AnimationController _controller;
  Animation<Size> _heightAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _heightAnimation = Tween<Size>(
      begin: Size(double.infinity, 260),
      end: Size(double.infinity, 800),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // _heightAnimation.addListener(() {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: ((cntx) => AlertDialog(
            title: Text(
              'Error !',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(cntx).pop();
                },
                child: Text('Okay'),
              ),
            ],
          )),
    );
  }

  Future<bool> _showCreatedUserID(String message) async {
    return await showDialog(
      context: context,
      builder: ((cntx) => AlertDialog(
            title: Text(
              'Congratulations..',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(message),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //  if (mounted) {
                  Navigator.of(null).pop(true);
                  //}
                },
                child: Text('Okay'),
              ),
            ],
          )),
    );
  }

  var _isLoading = false;
  final _passwordController = TextEditingController();
  String _userID;
  UserProfile userProfile = UserProfile(
    name: '',
    mobileNo: '',
    Address: '',
  );

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    if (mounted)
      setState(() {
        _isLoading = true;
      });

    try {
      String email;
      if (_authMode == AuthMode.Login) {
        await Provider.of<Auth>(context, listen: false)
            .login(Email: _authData['email'], Password: _authData['password']);

        //Navigator.of(context).pushReplacementNamed('/', arguments: email);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(Email: _authData['email'], Password: _authData['password'])
            .then((value) async {
          _userID = value['localId'];

          try {
            Provider.of<User>(context, listen: false)
                .addUserProfile(userId: _userID, profile: userProfile);
          } on HttpException catch (e) {
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text('Error Occured'),
                content: Text(e.toString()),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Okay'))
                ],
              ),
            );
          } catch (error) {}

          // bool result = await _showCreatedUserID(
          //     "Your User ID Created With User Name::" + value['email']);
          // if (result) {
          //   _switchAuthMode();
          // }
          //Navigator.of(context).pushReplacementNamed(AuthScreen.routeName);
        });
      }
    } on HttpException catch (error) {
      String errorMsg = 'Authentication Error';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMsg = 'Email Already Exist';
      } else if (error.toString().contains('OPERATION_NOT_ALLOWED')) {
        errorMsg = 'This Operation is not Allowed';
      } else if (error.toString().contains('TOO_MANY_ATTEMPTS_TRY_LATER')) {
        errorMsg = 'You made many attemps try after some time';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMsg = 'Email is not Registered with us ! Sign-UP';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMsg = 'Invalid Password';
      } else if (error.toString().contains('USER_DISABLED')) {
        errorMsg = 'Your Account has been Disabled';
      }

      // await _showDialog(errorMsg);
    } catch (error) {
      String errorMsg = 'Unable to Login Try Later !';
      // await _showDialog(errorMsg);

    }
    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
        height: _authMode == AuthMode.Signup ? 800 : 260,
        // height: _heightAnimation.value.height,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 800 : 260,
        ),
        width: deviceSize.width * 0.75,
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return 'Password is too short!';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _authData['password'] = value;
                  },
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                  constraints: BoxConstraints(
                      maxHeight: _authMode == AuthMode.Signup ? 60 : 0,
                      minHeight: _authMode == AuthMode.Signup ? 0 : 0),
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: TextFormField(
                      enabled: _authMode == AuthMode.Signup,
                      decoration:
                          InputDecoration(labelText: 'Confirm Password'),
                      obscureText: true,
                      validator: _authMode == AuthMode.Signup
                          ? (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
                              return null;
                            }
                          : null,
                    ),
                  ),
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Name'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Name';
                      }
                      if (value.length < 5) {
                        return 'Invalid Name, Minimum 5 Charachter Required';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userProfile = UserProfile(
                        name: value,
                        mobileNo: userProfile.mobileNo,
                        Address: userProfile.Address,
                      );
                    },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Mobile No'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Mobile Number is must for Delivery';
                      }
                      if (value.length < 10 || value.length > 12) {
                        return 'Ivalid Mobile No';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userProfile = UserProfile(
                        name: userProfile.name,
                        mobileNo: value,
                        Address: userProfile.Address,
                      );
                    },
                  ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: '#102, Shanti Nagar, BSL'),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Invalid Address ! Must for Delivery';
                      }
                      if (value.length > 30) {
                        return 'Max 30 letters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      userProfile = UserProfile(
                        name: userProfile.name,
                        mobileNo: userProfile.mobileNo,
                        Address: value,
                      );
                    },
                  ),
                SizedBox(
                  height: 20,
                ),
                if (_isLoading)
                  CircularProgressIndicator()
                else
                  RaisedButton(
                    child:
                        Text(_authMode == AuthMode.Login ? 'LOGIN' : 'SIGN UP'),
                    onPressed: _submit,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    color: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).primaryTextTheme.button.color,
                  ),
                FlatButton(
                  child: Text(
                      '${_authMode == AuthMode.Login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                  onPressed: _switchAuthMode,
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
