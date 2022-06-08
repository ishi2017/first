import 'package:flutter/material.dart';
import './transaction_list.dart';
import '../Module/Transaction.dart';

class NewTransaction extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyNewTransaction();
  }
}

class MyNewTransaction extends State<NewTransaction> {
  void addTx({String newTitle, double newAmount}) {
    final Transaction newtx = Transaction(
      id: DateTime.now().toString(),
      title: newTitle,
      amount: newAmount,
      date: DateTime.now(),
    );
    setState(() {
      transactions.add(newtx);
    });
  }

  final List<Transaction> transactions = [
    Transaction(
        id: '1',
        title: 'New Shoes Purchased',
        amount: 66.99,
        date: DateTime.now()),
  ];
  // String inputTitle, inputAmount;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  void submit() {
    String enteredTitle = titleController.text;
    double enteredAmount = double.parse(amountController.text);
    print(enteredTitle);
    print(enteredAmount);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    titleController.text = '';
    amountController.text = '';
    addTx(
      newTitle: enteredTitle,
      newAmount: enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      //margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Card(
            elevation: 5,
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titleController,
              keyboardType: TextInputType.name,
              onSubmitted: (_) => submit(),
              // onChanged: (val) {
              //   inputTitle = val;
              // },
            ),
          ),
          Card(
            elevation: 5,
            child: TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submit(),
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
            onPressed: submit,
            // print(titleController.text);
            // print(amountController.text);
            // print(inputTitle);
            // print(inputAmount);
          ),
          TransactionList(this.transactions),
        ],
      ),
    );
  }
}
