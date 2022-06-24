import 'package:flutter/material.dart';

class FavouritScreen extends StatelessWidget {
  static final String RouteName = '/FavScreen';
  const FavouritScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is my Favourit Page'),
    );
  }
}
