import 'package:expense_manager/widgets/chart_bar.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;
      for (int i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      // print(DateFormat.E().format(weekday));
      // print(totalSum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      // // print('sum : $sum ; amount : ${item['amount']}');
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(DateFormat.E().format(weekday));
    // print(groupedTransactionValues);
    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.03),
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues
              .map(
                (data) => Expanded(
                  // Flexible(
                  // fit: FlexFit.tight, // doing this to lines is same as Expanded!
                  child: ChartBar(
                    data['day'],
                    data['amount'],
                    (data['amount'] as double) / totalSpending,
                  ),
                ),
              )
              .toList()),
    );
  }
}
