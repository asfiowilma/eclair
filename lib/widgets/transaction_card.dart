import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function deleteTx;

  TransactionCard(this.tx, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          tx.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.grey[700],
              ),
        ),
        subtitle: Text(
          DateFormat('yMMMEd').format(tx.date),
        ),
        leading: Text(
          'Rp${tx.amount}',
          style: TextStyle(
            color: Theme.of(context).primaryColorDark,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 425
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text("Delete"),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () => deleteTx(tx.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => deleteTx(tx.id),
              ),
      ),
    );
  }
}
