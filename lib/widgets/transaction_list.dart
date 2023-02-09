import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;

  const TransactionList(
    this._userTransactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: Image.asset(
                  'assets/images/no_data.png',
                  fit: BoxFit.contain,
                ),
              ),
              Text(
                'No transactions added yet~',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: _userTransactions.length,
            itemBuilder: (ctx, i) =>
                TransactionCard(_userTransactions[i], deleteTx),
          );
  }
}
