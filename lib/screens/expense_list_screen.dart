import 'package:flutter/material.dart';
import '../data/expense_repository.dart';
import '../widgets/expense_card.dart';

class ExpenseListScreen extends StatelessWidget {
  const ExpenseListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expenses')),
      body: FutureBuilder(
        future: ExpenseRepository.getAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final items = snapshot.data ?? [];
          if (items.isEmpty) {
            return const Center(child: Text('No expenses yet'));
          }
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final e = items[index];
              return ExpenseCard(expense: e);
            },
          );
        },
      ),
    );
  }
}

