import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final Function addTx;

  TransactionForm(this.addTx);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTx() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) return;

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) return;
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitTx(),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen.'
                        : 'Transacted on: ${DateFormat.yMd().format(_selectedDate as DateTime)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Platform.isIOS
                      ? CupertinoButton(
                          onPressed: _showDatePicker,
                          child: Text(
                            _selectedDate == null
                                ? 'Choose Date'
                                : 'Change Date',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : TextButton(
                          onPressed: _showDatePicker,
                          child: Text(
                            _selectedDate == null
                                ? 'Choose Date'
                                : 'Change Date',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                ],
              ),
              Platform.isIOS
                  ? CupertinoButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: _submitTx,
                      child: const Text('Add Transaction'),
                    )
                  : ElevatedButton(
                      onPressed: _submitTx,
                      child: const Text('Add Transaction'),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
