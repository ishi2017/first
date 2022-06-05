import 'package:flutter/material.dart';

class TextBtn extends StatelessWidget {
  final Function fnc;

  TextBtn({this.fnc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          primary: Colors.green,
          onSurface: Colors.black,
        ),
        // style: ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.amber),
        //     foregroundColor: MaterialStateProperty.all(Colors.black)),
        child: Text('Text Button'),
        onPressed: fnc,
      ),
    );
  }
}
