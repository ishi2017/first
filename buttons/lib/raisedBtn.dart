import 'package:flutter/material.dart';

class RaisedBtn extends StatelessWidget {
  final Function fnc;

  RaisedBtn({this.fnc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          textColor: Colors.black,
          child: Text('Raised Button'),
          onPressed: fnc),
    );
  }
}
