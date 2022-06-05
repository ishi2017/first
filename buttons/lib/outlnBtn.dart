import 'package:flutter/material.dart';

class outlnBtn extends StatelessWidget {
  final Function fnc;

  outlnBtn({this.fnc});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      child: OutlinedButton(
          style: TextButton.styleFrom(
            primary: Colors.green,
            side: BorderSide(color: Colors.red),
          ),
          // style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all(Colors.amber),
          //     foregroundColor: MaterialStateProperty.all(Colors.black)),
          child: Text('It is a Outlined Button'),
          onPressed: fnc),
    );
  }
}
