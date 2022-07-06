import 'package:flutter/material.dart';
import '../screens/product_overview_screen.dart';
import 'package:provider/provider.dart';
import '../models/http_exception.dart';
import '../provider/auth.dart';
import '../provider/user_profile.dart';

class ClientInfo extends StatefulWidget {
  static String RouteName = '/Client-Info';

  ClientInfo({Key key}) : super(key: key);

  @override
  State<ClientInfo> createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  final _phoneFocusNode = FocusNode();

  final _addressFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  UserProfile newUser =
      UserProfile(userID: '', mobileNo: '', Address: '', name: '');

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _addressFocusNode.dispose();

    super.dispose();
  }

  void submitForm(BuildContext context) async {
    final validated = _formKey.currentState.validate();
    if (!validated) {
      return;
    }
    _formKey.currentState.save();

    final auth = Provider.of<Auth>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);

    try {
      //user.addUserProfile(userId: auth.userID, profile: newUser);

      user.updateProfile(userId: auth.userID, profile: newUser);
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
    }
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed(ProductOverviewScreen.RouteName);
  }

  @override
  Widget build(BuildContext context) {
    newUser = ModalRoute.of(context).settings.arguments as UserProfile;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
              onPressed: () {
                submitForm(context);
              },
              icon: Icon(
                Icons.save,
                color: Colors.blue,
              ))
        ],
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              initialValue: newUser.name,
              decoration: InputDecoration(
                  label: Text('Enter User Name'),
                  prefixIcon: Icon(
                    Icons.account_circle_outlined,
                    color: Colors.blue,
                  )),
              keyboardType: TextInputType.text,
              focusNode: _phoneFocusNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_phoneFocusNode);
              },
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                newUser = UserProfile(
                    userID: newUser.userID,
                    name: value,
                    mobileNo: newUser.mobileNo,
                    Address: newUser.Address);
              },
            ),
            TextFormField(
              initialValue: newUser.mobileNo,
              decoration: InputDecoration(
                  label: Text('Enter Phone No'),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.blue,
                  )),
              keyboardType: TextInputType.number,
              focusNode: _addressFocusNode,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(_addressFocusNode);
              },
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                newUser = UserProfile(
                    userID: newUser.userID,
                    name: newUser.name,
                    mobileNo: value,
                    Address: newUser.Address);
              },
            ),
            TextFormField(
              initialValue: newUser.Address,
              decoration: InputDecoration(
                  label: Text('Enter Complete Address'),
                  prefixIcon: Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                  )),
              keyboardType: TextInputType.text,
              maxLines: 3,
              validator: (value) {
                return null;
              },
              onSaved: (value) {
                newUser = UserProfile(
                    userID: newUser.userID,
                    name: newUser.name,
                    mobileNo: newUser.mobileNo,
                    Address: value);
              },
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                submitForm(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
