import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);
  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
            controller: titleController,
            onSubmitted: (_) => submitData(),
            decoration: InputDecoration(
              labelText: 'Title',
            ),
          ),
          TextField(
            controller: amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) =>
                submitData(), // '_' is because it will give some data and we don't need or use it now, so we just simply store it and ignore.
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
          TextButton(
            onPressed: submitData,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                color: Colors.purple,
              ),
            ),
          )
        ],
      ),
    );
  }
}
