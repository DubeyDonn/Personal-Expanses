import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lebal;
  final double percentOfTotalAmount;
  final double amount;

  const ChartBar(
      {required this.amount,
      required this.lebal,
      required this.percentOfTotalAmount,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            height: 20,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: FittedBox(child: Text('Rs.${amount.toStringAsFixed(0)}'))),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 86,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  color: const Color.fromARGB(255, 215, 215, 215),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: percentOfTotalAmount,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(lebal),
      ],
    );
  }
}
