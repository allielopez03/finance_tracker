import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  const ExpenseCard({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final df = DateFormat.yMMMd();
    return Card(
      margin: const EdgeInsets.symmetric(vertical:6, horizontal:12),
      child: ListTile(
        leading: CircleAvatar(child: Text('\$${expense.amount.toStringAsFixed(0)}')),
        title: Text(expense.category),
        subtitle: Text('${expense.description} • ${df.format(expense.date)}'),
        trailing: Text('\$${expense.amount.toStringAsFixed(2)}'),
      ),
    );
  }
}
