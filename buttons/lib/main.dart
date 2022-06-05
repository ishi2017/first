import 'package:flutter/material.dart';
import './raisedBtn.dart';
import './flatBtn.dart';
import './elevatedBtn.dart';
import './outlnBtn.dart';
import './TextBtn.dart';

void main() {
  runApp(MyButtons());
}

class MyButtons extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyButtonState();
  }
}

class MyButtonState extends State<MyButtons> {
  int i = 0;
  String msg;
  void setMsg() {
    setState(() {
      if (i == 0) {
        i = 1;
        this.msg = "Even";
      } else {
        i = 0;
        this.msg = 'Odd';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("This is My App"),
          ),
          body: Column(
            children: [
              Text(
                msg ??= "No Message is There",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber),
                textAlign: TextAlign.center,
              ),
              RaisedBtn(fnc: setMsg),
              flatBtn(fnc: setMsg),
              outlnBtn(
                fnc: setMsg,
              ),
              elevatedBtn(
                fnc: setMsg,
              ),
              TextBtn(
                fnc: setMsg,
              )
            ],
          )),
    );
  }
}
