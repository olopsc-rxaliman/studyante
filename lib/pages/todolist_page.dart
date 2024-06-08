import "package:animated_list_plus/transitions.dart";
import "package:flutter/material.dart";
import "package:animated_list_plus/animated_list_plus.dart";
import "package:studyante/components/todolist_dialog.dart";
import "package:studyante/components/todolist_item_widget.dart";
import "package:studyante/components/todolist_widget.dart";
import "package:studyante/hive/hive_todolist_functions.dart";

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({super.key});

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List taskList = [];

  @override
  void initState() {
    super.initState();
    refreshHiveData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void refreshHiveData() {
    setState(() {
      taskList = ToDoListHiveFunctions.getAllTasks();
      taskList.sort((a, b) => a['timestamp'].compareTo(b['timestamp']));
      taskList.sort((a, b) => a['status'].compareTo(b['status']));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          "TO-DO LIST",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.add_task,
          color: Colors.black,
        ),
        label: const Text(
          "Add Task",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[800],
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ToDoListDialog(
              onSubmit: () => refreshHiveData(),
            ),
          );
        },
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(5),
        children: [
          const ToDoListWidget(
            widgetColor: Colors.white,
            navigateOnClick: false,
          ),
          const SizedBox(height: 10),
          taskList.isEmpty
          ? const Center(
            child: Text("No such tasks. Nice!"),
          )
          : ImplicitlyAnimatedList<ToDoListItemWidget>(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            items: List<ToDoListItemWidget>.generate(
              taskList.length,
              (index) => ToDoListItemWidget(
                task: taskList[index],
                onSelected: () => refreshHiveData(),
              ),
            ).toList(),
            areItemsTheSame: (a, b) => a.key == b.key,
            itemBuilder: (context, animation, item, i) => SizeFadeTransition(
              sizeFraction: 0.7,
              curve: Curves.easeInOut,
              animation: animation,
              child: item,
            ),
            removeItemBuilder: (context, animation, item) => FadeTransition(
              opacity: animation,
              child: item,
            ),
          ),
        ],
      ),
    );
  }
}