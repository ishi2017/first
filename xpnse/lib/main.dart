import 'package:flutter/material.dart';
import './widgets/newTransaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xpanse Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Xpanse Manager',
          style: TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ),
      body: // SingleChildScrollView(child:
          Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.purple,
            child: Card(
              child: Text(
                ' Xpanse Manager ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Rockwell',
                ),
              ),
              color: Colors.purple,
            ),
          ),
          NewTransaction(),
        ],
      ),
    );
  }
}
