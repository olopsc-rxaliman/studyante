import "package:flutter/material.dart";

class ExpensesTrackerPage extends StatefulWidget {
  const ExpensesTrackerPage({super.key});

  @override
  State<ExpensesTrackerPage> createState() => _ExpensesTrackerPageState();
}

class _ExpensesTrackerPageState extends State<ExpensesTrackerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "EXPENSES TRACKER",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}