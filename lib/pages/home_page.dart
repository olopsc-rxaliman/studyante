import "package:flutter/material.dart";
import "package:studyante/components/datetime_widget.dart";
import "package:studyante/components/expensestracker_widget.dart";
import "package:studyante/components/memaquote_widget.dart";
import "package:studyante/components/routinebuilder_widget.dart";
import "package:studyante/components/todolist_widget.dart";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFAFA),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Studyante App",
          style: TextStyle(
            fontFamily: 'Lobster',
            fontSize: 30,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(5),
        physics: const BouncingScrollPhysics(),
        children: const [
          MemaQuoteWidget(),
          DateTimeWidget(),
          ToDoListWidget(
            title: "To-do List",
            widgetColor: Colors.amber,
            navigateOnClick: true,
          ),
          RoutineBuilderWidget(),
          ExpensesTrackerWidget(),
        ],
      ),
    );
  }
}