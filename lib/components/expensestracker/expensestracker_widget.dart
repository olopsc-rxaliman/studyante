import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/expensestracker_page.dart";

class ExpensesTrackerWidget extends StatelessWidget {
  const ExpensesTrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "Expenses Tracker",
      backgroundColor: Colors.lime,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ExpensesTrackerPage(),
        ),
      ),
      child: const Wrap(
        spacing: 30,
        runSpacing: 10,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "₱ 150.00",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text(
                "Total Expenses",
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
                "23%",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
              Text(
                "Increase from yesterday",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}