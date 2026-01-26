import "package:hive_ce_flutter/hive_ce_flutter.dart";
import "package:studyante/services/hive/hive_constants.dart";

class ExpensesHiveFunctions {
  static Box get expensesBox => Hive.box(expensesBoxName);

  // Create
  static Future<int> addExpense({
    required double amount,
    required String category,
    required String note,
    required DateTime date,
  }) =>
      expensesBox.add({
        'amount': amount,
        'category': category,
        'note': note,
        'date': date.toIso8601String(),
      });

  // Retrieve
  static List<Map<String, dynamic>> getAllExpenses() =>
      expensesBox.keys.map((key) {
        final data = expensesBox.get(key) as Map;
        return {
          'key': key,
          'amount': data['amount'] as double,
          'category': data['category'] as String,
          'note': data['note'] as String,
          'date': DateTime.parse(data['date'] as String),
        };
      }).toList();

  static List<Map<String, dynamic>> getExpensesForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 7));
    return getAllExpenses().where((expense) {
      final date = expense['date'] as DateTime;
      return date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
          date.isBefore(weekEnd);
    }).toList();
  }

  static double getTotalSpent() => getAllExpenses()
      .fold(0.0, (sum, expense) => sum + (expense['amount'] as double));

  static double getWeeklySpent(DateTime weekStart) =>
      getExpensesForWeek(weekStart)
          .fold(0.0, (sum, expense) => sum + (expense['amount'] as double));

  static Map<String, double> getSpendingByCategory() {
    final expenses = getAllExpenses();
    final Map<String, double> categoryTotals = {};
    for (final expense in expenses) {
      final category = expense['category'] as String;
      final amount = expense['amount'] as double;
      categoryTotals[category] = (categoryTotals[category] ?? 0) + amount;
    }
    return categoryTotals;
  }

  static Map<String, double> getDailySpendingForWeek(DateTime weekStart) {
    final expenses = getExpensesForWeek(weekStart);
    final Map<String, double> dailyTotals = {};
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    for (int i = 0; i < 7; i++) {
      dailyTotals[days[i]] = 0.0;
    }
    for (final expense in expenses) {
      final date = expense['date'] as DateTime;
      final dayIndex = date.weekday - 1;
      dailyTotals[days[dayIndex]] =
          (dailyTotals[days[dayIndex]] ?? 0) + (expense['amount'] as double);
    }
    return dailyTotals;
  }

  static double getAverageDailySpending() {
    final expenses = getAllExpenses();
    if (expenses.isEmpty) return 0.0;
    final dates = expenses.map((e) => e['date'] as DateTime).toList();
    dates.sort();
    final firstDate = dates.first;
    final lastDate = dates.last;
    final daysDiff = lastDate.difference(firstDate).inDays + 1;
    return getTotalSpent() / daysDiff;
  }

  // Update
  static Future<void> modifyExpense(int key, Map<String, dynamic> data) =>
      expensesBox.put(key, {
        'amount': data['amount'],
        'category': data['category'],
        'note': data['note'],
        'date': (data['date'] as DateTime).toIso8601String(),
      });

  // Delete
  static Future<void> deleteExpense(int key) => expensesBox.delete(key);
  static Future<void> deleteAllExpenses() =>
      expensesBox.deleteAll(expensesBox.keys);
}
