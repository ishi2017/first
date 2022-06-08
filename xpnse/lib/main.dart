import 'package:flutter/material.dart';
import './Transaction.dart';
import 'package:intl/intl.dart';

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
  // String inputTitle, inputAmount;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                    ),
                    controller: titleController,
                    // onChanged: (val) {
                    //   inputTitle = val;
                    // },
                  ),
                ),
                Card(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    // onChanged: (val) {
                    //   inputAmount = val;
                    // },
                  ),
                ),
                FlatButton(
                  child: Text(
                    'Add Transaction',
                    style: TextStyle(color: Colors.purple),
                  ),
                  onPressed: () {
                    print(titleController.text);
                    print(amountController.text);
                    // print(inputTitle);
                    // print(inputAmount);
                  },
                ),
              ],
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
                        border: Border.all(
                          color: Colors.purple,
                          width: 2,
                        ),
                      ),
                      padding: EdgeInsets.all(
                        10,
                      ),
                      child: Card(
                        child: Text(
                          '\$${e.amount}',
                          style: TextStyle(
                            fontFamily: 'Rockwell',
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: 250,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.purple,
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
                                  color: Colors.purple,
                                  fontSize: 15,
                                  fontFamily: 'Rockwell',
                                ),
                              ),
                            ),
                            Card(
                              child: Text(
                                // DateFormat('yyyy-MM-dd').format(e.date),
                                DateFormat.yMMMd().format(e.date),
                                style: TextStyle(
                                  color: Colors.purple,
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
