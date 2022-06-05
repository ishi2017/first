import 'dart:ui';

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function selectHandler;
  final String ans;

  Answer(this.selectHandler, this.ans);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.blue,
      child: RaisedButton(
        child: Text(
          this.ans,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: selectHandler,
        color: Colors.green,
        textColor: Colors.black,
      ),
    );
  }
}
