import 'package:flutter/material.dart';
import './Transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(
        id: '1',
        title: 'New Shoes Purchased',
        amount: 66.99,
        date: DateTime.now()),
    Transaction(
      id: '2',
      title: 'Purchased Grocery',
      amount: 100.0,
      date: DateTime.now(),
    ),
    Transaction(
      id: '3',
      title: 'Purchased Diary Item',
      amount: 10.0,
      date: DateTime.now(),
    ),
    Transaction(
      id: '4',
      title: 'Purchased Fruits',
      amount: 15.0,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            color: Colors.amber,
            child: Card(
              child: Text(
                ' Xpanse Manager ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Rockwell',
                ),
              ),
              color: Colors.amber,
            ),
          ),
          Column(
            children: [
              ...transactions.map((e) {
                return Row(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Card(
                        child: Text(
                          e.amount.toString(),
                          style: TextStyle(
                            fontFamily: 'Rockwell',
                            fontSize: 20,
                          ),
                        ),
                        color: Colors.amber,
                      ),
                    ),
                    Container(
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              child: Text(
                                e.title,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Rockwell',
                                ),
                              ),
                            ),
                            Card(
                              child: Text(
                                e.date.toString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'Rockwell',
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
