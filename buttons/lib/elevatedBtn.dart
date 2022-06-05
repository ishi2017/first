import 'package:flutter/material.dart';

class elevatedBtn extends StatelessWidget {
  final Function fnc;

  elevatedBtn({this.fnc});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.green,
          onPrimary: Colors.black,
        ),
        // ButtonStyle(
        //     backgroundColor: MaterialStateProperty.all(Colors.amber),
        //     foregroundColor: MaterialStateProperty.all(Colors.black)),
        child: Text('Elevated Button'),
        onPressed: fnc,
      ),
    );
  }
}
