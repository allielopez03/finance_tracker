import '../models/expense.dart';

class ExpenseRepository {
  // In-memory list for Sprint 1 UI
  static final List<Expense> _expenses = [
    Expense(amount: 12.50, category: 'Food', description: 'Lunch', date: DateTime.now()),
    Expense(amount: 5.99, category: 'Transport', description: 'Bus', date: DateTime.now().subtract(Duration(days:1))),
  ];

  static List<Expense> getAll() => List.unmodifiable(_expenses);

  static void add(Expense e) {
    _expenses.add(e);
  }

  static double totalForDay(DateTime day) {
    final d = DateTime(day.year, day.month, day.day);
    return _expenses
        .where((e) {
      final ed = DateTime(e.date.year, e.date.month, e.date.day);
      return ed == d;
    })
        .fold(0.0, (s, e) => s + e.amount);
  }

  static double totalForWeek(DateTime date) {
    // simple week: last 7 days
    final cutoff = date.subtract(Duration(days: 6));
    return _expenses.where((e) => e.date.isAfter(cutoff.subtract(Duration(seconds:1)))).fold(0.0, (s,e) => s + e.amount);
  }
}
