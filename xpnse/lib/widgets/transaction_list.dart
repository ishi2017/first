import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Module/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text(
                  "No Existing Transaction",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 350,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColorLight,
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                          //style: Theme.of(context).textTheme.headline6,

                          style: TextStyle(
                              color: Theme.of(context).primaryColorDark),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            style: Theme.of(context).textTheme.headline6,

                            // style:
                            //     TextStyle(color: Theme.of(context).primaryColorDark),

                            // style: TextStyle(
                            //   fontSize: 16,
                            //   fontWeight: FontWeight.bold,
                            //   color: Theme.of(context).primaryColorDark,
                            // ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index].date),
                            style: Theme.of(context).textTheme.headline6,
                            // style:
                            //     TextStyle(color: Theme.of(context).primaryColorDark),
                            // style: TextStyle(
                            //   color: Theme.of(context).primaryColorDark,
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
