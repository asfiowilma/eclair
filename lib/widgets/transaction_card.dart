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
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.red,
          onPressed: () => deleteTx(tx.id),
        ),
      ),
    );

    // Card(
    //   child: Container(
    //     padding: const EdgeInsets.all(16),
    //     child:
    //         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             tx.title,
    //             style: Theme.of(context).textTheme.titleMedium!.copyWith(
    //                   color: Colors.grey[700],
    //                 ),
    //           ),
    //           Text(
    //             DateFormat('yMMMEd').format(tx.date),
    //             style: const TextStyle(
    //               color: Colors.grey,
    //             ),
    //           )
    //         ],
    //       ),
    //       Text(
    //         'Rp${tx.amount}',
    //         style: TextStyle(
    //           color: Theme.of(context).primaryColorDark,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 16,
    //         ),
    //       ),
    //     ]),
    //   ),
    // );
  }
}
