import 'package:flutter/material.dart';
import 'package:personal_expenses/widgets/add_transactrions.dart';
import 'package:personal_expenses/widgets/chart.dart';
import 'package:personal_expenses/widgets/transactions_list.dart';

import 'models/transaction.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'Open Sans',
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
      ),
      title: 'My Expenses',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //   title: 'Khaja',
    //   amount: 215,
    //   id: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   amount: 150,
    //   date: DateTime.now(),
    //   title: 'FIFA',
    // ),
    // Transaction(
    //   title: 'Khaja',
    //   amount: 215,
    //   id: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   amount: 150,
    //   date: DateTime.now(),
    //   title: 'FIFA',
    // ),
    // Transaction(
    //   title: 'Khaja',
    //   amount: 215,
    //   id: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   amount: 150,
    //   date: DateTime.now(),
    //   title: 'FIFA',
    // ),
    // Transaction(
    //   title: 'Khaja',
    //   amount: 215,
    //   id: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   amount: 150,
    //   date: DateTime.now(),
    //   title: 'FIFA',
    // ),
    // Transaction(
    //   title: 'Khaja',
    //   amount: 215,
    //   id: 1,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   amount: 150,
    //   date: DateTime.now(),
    //   title: 'FIFA',
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      amount: txAmount,
      date: txDate,
      title: txTitle,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddTransactions(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddTransactions(
            _addNewTransactions,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddTransactions(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('My Expenses'),
        actions: [
          IconButton(
            onPressed: () => _startAddTransactions(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Chart(_transactions),
            TransactionsList(
              _transactions,
              _deleteTransaction,
            )
          ],
        ),
      ),
    );
  }
}
