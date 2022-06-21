import 'package:flutter/material.dart';
import '../Module/Transaction.dart';
import 'package:intl/intl.dart';
import './Chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalSum = 0.0;
      for (var v in recentTransactions) {
        if (v.date.day == weekDay.day &&
            v.date.month == weekDay.month &&
            v.date.year == weekDay.year) {
          totalSum += v.amount;
        }
      }

      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    });
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      elevation: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.loose,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingpercentageTotal: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }),
        ],
      ),
    );
  }
}
