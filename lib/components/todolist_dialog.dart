import "package:flutter/material.dart";
import "package:studyante/hive/hive_todolist_functions.dart";

class ToDoListDialog extends StatelessWidget {
  final Function() onSubmit;
  final Map? task;

  const ToDoListDialog({
    super.key,
    required this.onSubmit,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController taskInputController = TextEditingController(text: task?['task']);
    TextEditingController descInputController = TextEditingController(text: task?['description']);

    return AlertDialog(
      title: const Text("Add Task"),
      insetPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: Colors.white,
      actions: [
        task == null
        ? const SizedBox()
        : TextButton(
          onPressed: () {
            ToDoListHiveFunctions.deleteTask(task!['key']);
            Navigator.of(context).pop();
            onSubmit();
          },
          child: const Text("Delete"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Back"),
        ),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (task == null) {
                await ToDoListHiveFunctions.addTask(
                  task: taskInputController.text,
                  description: descInputController.text,
                  timestamp: DateTime.now().toIso8601String(),
                );
              }
              else {
                await ToDoListHiveFunctions.modifyTask(task!['key'], {
                  ...?task,
                  'task': taskInputController.text,
                  'description': descInputController.text,
                });
              }
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
              onSubmit();
            }
          },
          child: task == null ? const Text("Add") : const Text("Apply"),
        ),
      ],
      content: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 0,
        ),
        child: IntrinsicHeight(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: taskInputController,
                  decoration: const InputDecoration(
                    label: Text("Task"),
                    border: OutlineInputBorder(),
                  ),
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) return "This field is required";
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: descInputController,
                  decoration: const InputDecoration(
                    label: Text("Description"),
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}