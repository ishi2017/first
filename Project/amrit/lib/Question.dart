import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String Quesion;

  Question(this.Quesion);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10.0),
        color: Colors.purple,
        child: Text(
          Quesion,
          style: TextStyle(fontSize: 22, fontFamily: 'Rockwell'),
          textAlign: TextAlign.center,
        ));
  }
}
