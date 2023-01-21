import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';
import 'package:personal_expenses/widgets/chart_bar.dart';

// ignore: must_be_immutable
class Chart extends StatelessWidget {
  List<Transaction> transactions;

  Chart(this.transactions, {super.key});

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      double totalAmount = 0;
      final weekDay = DateTime.now().subtract(Duration(days: 6 - index));

      for (int i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalAmount = totalAmount + transactions[i].amount;
        }
      }

      return {
        'dayStamp': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount,
      };
    });
  }

  double get totalRecentWeekSpending {
    return groupedTransactions.fold<double>(
        0.0, (sum, element) => sum + (element['amount'] as double));
  }

  double get maxRecentWeekSpending {
    var max = 0.0;
    for (int i = 0; i < groupedTransactions.length; i++) {
      if (max < (groupedTransactions[i]['amount'] as double)) {
        max = groupedTransactions[i]['amount'] as double;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
      elevation: 10,
      child: Container(
        height: 150,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((txMap) =>
                  //Text('${txMap['dayStamp']} : ${txMap['amount']}'),
                  Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                        amount: (txMap['amount'] as double),
                        lebal: (txMap['dayStamp'] as String),
                        percentOfTotalAmount: maxRecentWeekSpending <= 0
                            ? 0.0
                            : ((txMap['amount'] as double) /
                                maxRecentWeekSpending)),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
