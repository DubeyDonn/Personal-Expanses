import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransactions extends StatefulWidget {
  final Function addTransactions;

  const AddTransactions(this.addTransactions, {super.key});

  @override
  State<AddTransactions> createState() => _AddTransactionsState();
}

class _AddTransactionsState extends State<AddTransactions> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  void _onSubmitted() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount < 0 || _selectedDate == null) {
      return;
    }

    widget.addTransactions(title, amount, _selectedDate);
    Navigator.of(context).pop();
  }

  void _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              hintStyle: TextStyle(color: Colors.grey.shade400),
            ),
            controller: _titleController,
            onSubmitted: (_) => _onSubmitted(),
          ),
          TextField(
            decoration: InputDecoration(
                labelText: 'Amount',
                hintStyle: TextStyle(color: Colors.grey.shade400)),
            controller: _amountController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => _onSubmitted(),
          ),
          Row(
            children: [
              Expanded(
                  child: Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}')),
              TextButton(
                onPressed: _chooseDate,
                child: const Text(
                  'Choose Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          ElevatedButton(
            onPressed: _onSubmitted,
            child: const Text('Add Transaction'),
          )
        ]),
      ),
    );
  }
}
