import 'package:flutter/material.dart';
import '../Module/Transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            color: Colors.lightBlue,
            shadowColor: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 5,
                    vertical: 5,
                  ),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.purple,
                      width: 2,
                    ),
                  ),
                  child: Text(
                    '\$${transactions[index].amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'Rockwell',
                      fontSize: 20,
                      color: Colors.purple,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      transactions[index].title,
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 15,
                        fontFamily: 'Rockwell',
                      ),
                    ),
                    Text(
                      // DateFormat('yyyy-MM-dd').format(e.date),
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.purple,
                        fontSize: 15,
                        fontFamily: 'Rockwell',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
