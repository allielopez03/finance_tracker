import 'package:flutter/material.dart';
import '../data/expense_repository.dart';
import '../widgets/expense_card.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = ExpenseRepository.getAll().reversed.toList(); // newest first
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: items.isEmpty
          ? const Center(child: Text('No expenses yet'))
          : ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final e = items[index];
          return ExpenseCard(expense: e);
        },
      ),
    );
  }
}
