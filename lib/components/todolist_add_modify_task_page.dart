import "package:flutter/material.dart";
import "package:studyante/hive/hive_todolist_functions.dart";

class ToDoListAddModifyTaskPage extends StatelessWidget {
  final Function() onSubmit;
  final Map? task;

  const ToDoListAddModifyTaskPage({
    super.key,
    required this.onSubmit,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController taskInputController = TextEditingController(text: task?['task']);
    TextEditingController descInputController = TextEditingController(text: task?['description']);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          task == null ? "Add Task" : "Modify Task",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber[700],
        foregroundColor: Colors.black,
        child: Icon(
          task == null ? Icons.add : Icons.check,
        ),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: taskInputController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  label: Text(
                    "Task",
                    style: TextStyle(color: Colors.black),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                  ),
                ),
                autofocus: true,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) return "This field is required";
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: descInputController,
                cursorColor: Colors.black,
                maxLines: null,
                decoration: const InputDecoration(
                  label: Text(
                    "Description",
                    style: TextStyle(color: Colors.black),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                  ),
                ),
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 10),
              task == null
              ? const SizedBox()
              : TextButton.icon(
                label: const Text("Delete"),
                icon: const Icon(Icons.delete),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                ),
                onPressed: () {
                  ToDoListHiveFunctions.deleteTask(task!['key']);
                  Navigator.of(context).pop();
                  onSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}