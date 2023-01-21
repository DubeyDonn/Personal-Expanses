import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  const TransactionsList(this.transactions, this.deleteTx, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: transactions.isNotEmpty
          ? ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Column(
                          children: [
                            const Text('Rs.'),
                            Text(transactions[index].amount.toStringAsFixed(0)),
                          ],
                        )),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.headline6),
                    subtitle: Text(
                      DateFormat.yMMMEd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () {
                        deleteTx(transactions[index].id as String);
                      },
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Container(
                  //       margin: const EdgeInsets.symmetric(
                  //           vertical: 10, horizontal: 15),
                  //       padding: const EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //           border: Border.all(
                  //               width: 2,
                  //               color: Theme.of(context).primaryColor)),
                  //       height: 40,
                  //       child: Center(
                  //           child: Text(
                  //         'Rs.${transactions[index].amount.toStringAsFixed(0)}',
                  //         style: TextStyle(
                  //             color: Theme.of(context).primaryColor,
                  //             fontWeight: FontWeight.bold),
                  //       )),
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Text(transactions[index].title,
                  //             style: Theme.of(context).textTheme.headline6),
                  //         Text(
                  //           DateFormat.yMMMEd()
                  //               .format(transactions[index].date),
                  //           style: TextStyle(color: Colors.grey[500]),
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),
                );
              },
            )
          : Center(
              child: Stack(alignment: Alignment.center, children: [
                Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.cover,
                  height: 800,
                  //color: Theme.of(context).primaryColor,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                      height: 200,
                      //color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 30),
                    const Center(
                      child: Text('No transactions added yet!',
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ]),
            ),
    );
  }
}
