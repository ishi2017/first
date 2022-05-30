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
        child: Text(this.ans),
        onPressed: selectHandler,
        color: Colors.red,
        textColor: Colors.orange,
      ),
    );
  }
}
