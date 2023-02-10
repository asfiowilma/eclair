import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctOfTotal;

  ChartBar(
    this.label,
    this.spendingAmount,
    this.spendingPctOfTotal,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraint) {
        return Column(
          children: [
            SizedBox(
              height: constraint.maxHeight * 0.12,
              child: FittedBox(child: Text(label)),
            ),
            Container(
              height: constraint.maxHeight * 0.7 - 16,
              width: 16,
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 8,
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              height: constraint.maxHeight * 0.15,
              child: FittedBox(
                child: Text('Rp${(spendingAmount / 1000).round()}K'),
              ),
            ),
          ],
        );
      },
    );
  }
}
