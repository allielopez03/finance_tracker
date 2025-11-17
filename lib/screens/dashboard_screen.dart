import 'package:flutter/material.dart';
import '../data/expense_repository.dart';
import 'expense_list_screen.dart';
import 'add_expense_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  double todayTotal = 0;
  double weekTotal = 0;

  void _refreshTotals() {
    final now = DateTime.now();
    setState(() {
      todayTotal = ExpenseRepository.totalForDay(now);
      weekTotal = ExpenseRepository.totalForWeek(now);
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTotals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Finance Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () async {
              await Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseListScreen()));
              _refreshTotals();
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExpenseScreen()));
          _refreshTotals();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: const Text('Today'),
                subtitle: const Text('Total spent today'),
                trailing: Text('\$${todayTotal.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: ListTile(
                title: const Text('This week'),
                subtitle: const Text('Total spent last 7 days'),
                trailing: Text('\$${weekTotal.toStringAsFixed(2)}'),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text('Add Expense'),
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExpenseScreen()));
                        _refreshTotals();
                      },
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.receipt_long),
                      label: const Text('View All'),
                      onPressed: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (_) => const ExpenseListScreen()));
                        _refreshTotals();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
