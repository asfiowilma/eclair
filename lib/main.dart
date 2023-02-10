import 'dart:io';

import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/transaction_form.dart';
import 'package:expense_tracker/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Expenses Tracker',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Poppins',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              displayMedium: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              labelLarge: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];
  bool _isShowChart = true;

  List<Transaction> get _recentTransactions {
    return _userTransactions
        .where(
          (tx) => tx.date.isAfter(
            DateTime.now().subtract(
              const Duration(days: 7),
            ),
          ),
        )
        .toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: txDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: TransactionForm(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  PreferredSizeWidget _buildMaterialAppBar() => AppBar(
        title: const Text('Daily Expense Tracker'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: const Icon(Icons.add),
          )
        ],
      );

  ObstructingPreferredSizeWidget _buildCupertinoAppBar() =>
      CupertinoNavigationBar(
        middle: const Text('Daily Expense Tracker'),
        trailing: GestureDetector(
          child: const Icon(CupertinoIcons.add),
          onTap: () => _startAddNewTransaction(context),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar =
        Platform.isIOS ? _buildCupertinoAppBar() : _buildMaterialAppBar();

    double vHeight = mediaQuery.size.height -
        mediaQuery.padding.top -
        appBar.preferredSize.height;

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Expenses This Week',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                if (isLandscape)
                  Row(
                    children: [
                      Text(
                        'Show',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Platform.isIOS
                          ? CupertinoSwitch(
                              activeColor: Theme.of(context).primaryColor,
                              value: _isShowChart,
                              onChanged: (to) => setState(() {
                                _isShowChart = to;
                              }),
                            )
                          : Switch.adaptive(
                              value: _isShowChart,
                              onChanged: (to) => setState(() {
                                _isShowChart = to;
                              }),
                            ),
                    ],
                  ),
              ],
            ),
            Visibility(
              visible: (_isShowChart && isLandscape) || !isLandscape,
              child: SizedBox(
                height: isLandscape ? vHeight * 0.65 : vHeight * 0.25,
                child: Chart(_recentTransactions),
              ),
            ),
            Visibility(
              visible: (isLandscape && !_isShowChart) || !isLandscape,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                ),
                child: Text(
                  'All Expenses',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            Visibility(
              visible: (isLandscape && !_isShowChart) || !isLandscape,
              child: SizedBox(
                height: vHeight * 0.6,
                width: double.infinity,
                child: TransactionList(_userTransactions, _deleteTransaction),
              ),
            ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _startAddNewTransaction(context),
              child: const Icon(Icons.add),
            ),
            body: pageBody);
  }
}
