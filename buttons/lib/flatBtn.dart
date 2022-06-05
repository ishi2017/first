import 'package:flutter/material.dart';

class flatBtn extends StatelessWidget {
  final Function fnc;

  flatBtn({this.fnc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlatButton(
          textColor: Colors.black,
          child: Text('It is a Flat Button'),
          onPressed: fnc),
    );
  }
}
