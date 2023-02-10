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
        ? LayoutBuilder(
            builder: (ctx, constraints) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: constraints.maxHeight * 0.75,
                  child: Image.asset(
                    'assets/images/no_data.png',
                    fit: BoxFit.contain,
                  ),
                ),
                Text(
                  'No transactions added yet~',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          )
        : ListView.builder(
            itemCount: _userTransactions.length,
            itemBuilder: (ctx, i) => TransactionCard(
              _userTransactions[i],
              deleteTx,
            ),
          );
  }
}
