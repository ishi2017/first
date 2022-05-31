import 'package:flutter/material.dart';

class result extends StatelessWidget {
  final int totalScore;
  final Function reset;
  result({this.totalScore, this.reset});

  String get resultPharase {
    String resultText;
    if (totalScore < 4) {
      resultText = "You have Best Choice";
    } else if (totalScore < 7) {
      resultText = "You have better Choice";
    } else {
      resultText = "Your Choice is Ok OK";
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              resultPharase,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          FlatButton(
            onPressed: reset,
            child: Text(
              'Reset',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic),
            ),
            textColor: Colors.brown,
          ),
        ],
      ),
    );
  }
}
