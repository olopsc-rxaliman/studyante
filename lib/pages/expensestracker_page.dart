import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_ce_flutter.dart";
import "package:studyante/services/hive/hive_constants.dart";
import "package:studyante/services/hive/hive_expenses_functions.dart";
import "package:studyante/pages/expense_stats_page.dart";
import "package:intl/intl.dart";

class ExpensesTrackerPage extends StatefulWidget {
  const ExpensesTrackerPage({super.key});

  @override
  State<ExpensesTrackerPage> createState() => _ExpensesTrackerPageState();
}

class _ExpensesTrackerPageState extends State<ExpensesTrackerPage> {
  final TextEditingController _budgetController = TextEditingController();
  double _remainingBudget = 0.0;
  DateTime _currentWeekStart = _getWeekStart(DateTime.now());

  static DateTime _getWeekStart(DateTime date) {
    final diff = date.weekday - 1;
    return DateTime(date.year, date.month, date.day - diff);
  }

  @override
  void dispose() {
    _budgetController.dispose();
    super.dispose();
  }

  double get _averageDailySpending =>
      ExpensesHiveFunctions.getAverageDailySpending();

  int get _forecastDaysRemaining {
    if (_averageDailySpending <= 0) return -1; // Infinite
    return (_remainingBudget / _averageDailySpending).floor();
  }

  String _formatDuration(int days) {
    if (days >= 365) {
      final years = days ~/ 365;
      final remainingMonths = (days % 365) ~/ 30;
      if (remainingMonths > 0) {
        return "$years year${years > 1 ? 's' : ''}, $remainingMonths month${remainingMonths > 1 ? 's' : ''}";
      }
      return "$years year${years > 1 ? 's' : ''}";
    } else if (days >= 30) {
      final months = days ~/ 30;
      final remainingWeeks = (days % 30) ~/ 7;
      if (remainingWeeks > 0) {
        return "$months month${months > 1 ? 's' : ''}, $remainingWeeks week${remainingWeeks > 1 ? 's' : ''}";
      }
      return "$months month${months > 1 ? 's' : ''}";
    } else if (days >= 7) {
      final weeks = days ~/ 7;
      final remainingDays = days % 7;
      if (remainingDays > 0) {
        return "$weeks week${weeks > 1 ? 's' : ''}, $remainingDays day${remainingDays > 1 ? 's' : ''}";
      }
      return "$weeks week${weeks > 1 ? 's' : ''}";
    }
    return "$days day${days > 1 ? 's' : ''}";
  }

  String get _forecastMessage {
    if (_remainingBudget <= 0) return "Enter your remaining budget above";
    if (_forecastDaysRemaining < 0) return "No spending data yet";
    if (_forecastDaysRemaining == 0) return "⚠️ Budget depleted today!";
    if (_forecastDaysRemaining <= 3)
      return "⚠️ Budget ends in ${_formatDuration(_forecastDaysRemaining)}!";
    if (_forecastDaysRemaining <= 7)
      return "Budget lasts ~${_formatDuration(_forecastDaysRemaining)}";
    return "✅ Budget looks safe (~${_formatDuration(_forecastDaysRemaining)})";
  }

  void _showAddExpenseDialog() {
    final amountController = TextEditingController();
    final noteController = TextEditingController();
    String selectedCategory = "Food";
    final categories = [
      "Food",
      "Transport",
      "School",
      "Entertainment",
      "Other"
    ];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text("Add Expense"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    prefixText: "₱ ",
                  ),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedCategory,
                  decoration: const InputDecoration(labelText: "Category"),
                  items: categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) {
                    setDialogState(() => selectedCategory = val ?? "Food");
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: noteController,
                  decoration:
                      const InputDecoration(labelText: "Note (optional)"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            FilledButton(
              onPressed: () async {
                final amount = double.tryParse(amountController.text);
                if (amount == null || amount <= 0) return;
                await ExpensesHiveFunctions.addExpense(
                  amount: amount,
                  category: selectedCategory,
                  note: noteController.text,
                  date: DateTime.now(),
                );
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime[50],
      appBar: AppBar(
        backgroundColor: Colors.lime,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "EXPENSES TRACKER",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: "Statistics",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ExpenseStatsPage()),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lime[700],
        onPressed: _showAddExpenseDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box(expensesBoxName).listenable(),
        builder: (context, Box box, _) {
          final weeklyExpenses =
              ExpensesHiveFunctions.getExpensesForWeek(_currentWeekStart);
          final weeklyTotal = weeklyExpenses.fold(
              0.0, (sum, e) => sum + (e['amount'] as double));
          final allExpenses = ExpensesHiveFunctions.getAllExpenses()
            ..sort((a, b) =>
                (b['date'] as DateTime).compareTo(a['date'] as DateTime));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Budget Input Card
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Remaining Budget",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _budgetController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixText: "₱ ",
                            hintText: "Enter your remaining budget",
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _remainingBudget = double.tryParse(val) ?? 0.0;
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: _forecastDaysRemaining <= 3 &&
                                    _remainingBudget > 0
                                ? Colors.red[100]
                                : Colors.green[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _forecastMessage,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _forecastDaysRemaining <= 3 &&
                                      _remainingBudget > 0
                                  ? Colors.red[800]
                                  : Colors.green[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Weekly Summary Card
                Card(
                  elevation: 3,
                  color: Colors.lime[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Weekly Spending",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              DateFormat('MMM d').format(_currentWeekStart) +
                                  " - " +
                                  DateFormat('MMM d').format(_currentWeekStart
                                      .add(const Duration(days: 6))),
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "₱ ${weeklyTotal.toStringAsFixed(2)}",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.lime[900],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Avg daily: ₱ ${_averageDailySpending.toStringAsFixed(2)}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Expense List Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Expenses",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    Text(
                      "${allExpenses.length} total",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Expense List
                if (allExpenses.isEmpty)
                  const Card(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          "No expenses yet.\nTap + to add one!",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                else
                  ...allExpenses.take(20).map((expense) => Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.lime[200],
                            child: Icon(
                              _getCategoryIcon(expense['category'] as String),
                              color: Colors.lime[900],
                            ),
                          ),
                          title: Text(
                            "₱ ${(expense['amount'] as double).toStringAsFixed(2)}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "${expense['category']}${(expense['note'] as String).isNotEmpty ? ' • ${expense['note']}' : ''}",
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                DateFormat('MMM d')
                                    .format(expense['date'] as DateTime),
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey[600]),
                              ),
                              Text(
                                DateFormat('h:mm a')
                                    .format(expense['date'] as DateTime),
                                style: TextStyle(
                                    fontSize: 11, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                          onLongPress: () =>
                              _showDeleteDialog(expense['key'] as int),
                        ),
                      )),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "Food":
        return Icons.restaurant;
      case "Transport":
        return Icons.directions_bus;
      case "School":
        return Icons.school;
      case "Entertainment":
        return Icons.movie;
      default:
        return Icons.receipt;
    }
  }

  void _showDeleteDialog(int key) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Expense"),
        content: const Text("Are you sure you want to delete this expense?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              await ExpensesHiveFunctions.deleteExpense(key);
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text("Delete"),
          ),
        ],
      ),
    );
  }
}
