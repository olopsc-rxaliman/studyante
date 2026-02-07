import "package:flutter/material.dart";
import "package:hive_ce_flutter/hive_ce_flutter.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/expensestracker_page.dart";
import "package:studyante/services/hive/hive_constants.dart";
import "package:studyante/services/hive/hive_expenses_functions.dart";

class ExpensesTrackerWidget extends StatelessWidget {
  const ExpensesTrackerWidget({super.key});

  static DateTime _getWeekStart(DateTime date) {
    final diff = date.weekday - 1;
    return DateTime(date.year, date.month, date.day - diff);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(expensesBoxName).listenable(),
      builder: (context, Box box, _) {
        final weekStart = _getWeekStart(DateTime.now());
        final weeklyTotal = ExpensesHiveFunctions.getWeeklySpent(weekStart);

        // Calculate today's and yesterday's spending
        final now = DateTime.now();
        final todayStart = DateTime(now.year, now.month, now.day);
        final yesterdayStart = todayStart.subtract(const Duration(days: 1));

        final allExpenses = ExpensesHiveFunctions.getAllExpenses();
        final todaySpending = allExpenses
            .where((e) => (e['date'] as DateTime)
                .isAfter(todayStart.subtract(const Duration(seconds: 1))))
            .fold(0.0, (sum, e) => sum + (e['amount'] as double));
        final yesterdaySpending = allExpenses.where((e) {
          final date = e['date'] as DateTime;
          return date.isAfter(
                  yesterdayStart.subtract(const Duration(seconds: 1))) &&
              date.isBefore(todayStart);
        }).fold(0.0, (sum, e) => sum + (e['amount'] as double));

        // Calculate percentage change
        double percentChange = 0;
        String changeLabel = "No change from yesterday";
        if (yesterdaySpending > 0) {
          percentChange =
              ((todaySpending - yesterdaySpending) / yesterdaySpending) * 100;
          if (percentChange > 0) {
            changeLabel = "Increase from yesterday";
          } else if (percentChange < 0) {
            changeLabel = "Decrease from yesterday";
          } else {
            changeLabel = "Same as yesterday";
          }
        } else if (todaySpending > 0) {
          changeLabel = "New spending today";
          percentChange = 100;
        }

        return BaseWidget(
          title: "Expenses Tracker",
          backgroundColor: Colors.lime,
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ExpensesTrackerPage(),
            ),
          ),
          child: Wrap(
            spacing: 30,
            runSpacing: 10,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "₱ ${weeklyTotal.toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  const Text(
                    "Weekly Expenses",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${percentChange >= 0 ? '+' : ''}${percentChange.toStringAsFixed(0)}%",
                    style: TextStyle(
                      color: percentChange > 0
                          ? Colors.red[800]
                          : percentChange < 0
                              ? Colors.green[800]
                              : Colors.black,
                      fontSize: 25,
                    ),
                  ),
                  Text(
                    changeLabel,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
