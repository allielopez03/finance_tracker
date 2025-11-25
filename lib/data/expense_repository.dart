import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/expense.dart';

class ExpenseRepository {
  // Firestore collection reference
  static final CollectionReference _collection =
  FirebaseFirestore.instance.collection('expenses');

  /// Get all expenses
  static Future<List<Expense>> getAll() async {
    final snapshot = await _collection.orderBy('date', descending: true).get();
    return snapshot.docs.map((doc) => Expense(
      amount: (doc['amount'] as num).toDouble(),
      category: doc['category'] as String,
      description: doc['description'] as String,
      date: (doc['date'] as Timestamp).toDate(),
    )).toList();
  }

  /// Add a new expense
  static Future<void> add(Expense e) async {
    await _collection.add({
      'amount': e.amount,
      'category': e.category,
      'description': e.description,
      'date': Timestamp.fromDate(e.date),
    });
  }

  /// Total spent today
  static Future<double> totalForDay(DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final snapshot = await _collection
        .where('date', isGreaterThanOrEqualTo: start, isLessThan: end)
        .get();

    double total = 0.0;
    for (var doc in snapshot.docs) {
      total += (doc['amount'] as num).toDouble();
    }
    return total;
  }

  /// Total spent last 7 days
  static Future<double> totalForWeek(DateTime date) async {
    final cutoff = date.subtract(const Duration(days: 6));
    final snapshot = await _collection
        .where('date', isGreaterThanOrEqualTo: cutoff)
        .get();

    double total = 0.0;
    for (var doc in snapshot.docs) {
      total += (doc['amount'] as num).toDouble();
    }
    return total;
  }
}



