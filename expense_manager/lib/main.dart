import 'package:expense_manager/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transaction = [
    Transaction(
      id: 't1',
      title: 'Shoes',
      amount: 499,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Grocery',
      amount: 300,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          child: Card(
            color: Colors.blue,
            child: Text(
              'Charts',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    color: Colors.purple,
                  ),
                ),
              )
            ],
          ),
        ),
        Column(
          children: transaction
              .map((trans) => Card(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            '₹ ${trans.amount}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.purple,
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.purple,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              trans.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              DateFormat.yMMMd().format(trans.date),
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
