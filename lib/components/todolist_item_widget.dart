import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/components/todolist_add_modify_task_page.dart";
import "package:studyante/hive/hive_constants.dart";
import "package:studyante/hive/hive_todolist_functions.dart";

class ToDoListItemWidget extends StatelessWidget {
  final Map task;
  final Function() onSelected;

  const ToDoListItemWidget({
    super.key,
    required this.task,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    Icon statusIcon = task['status'] == TaskStatus.active.index
    ? const Icon(
      Icons.circle,
      color: Colors.green,
      size: 18,
    ) : task['status'] == TaskStatus.done.index
    ? const Icon(
      Icons.circle,
      color: Colors.blue,
      size: 18,
    ) : task['status'] == TaskStatus.inProgress.index
    ? const Icon(
      Icons.circle,
      color: Colors.red,
      size: 18,
    ) : const Icon(
      Icons.circle_outlined,
      size: 18,
    );
    return BaseWidget(
      backgroundColor: Colors.white,
      onLongPress: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ToDoListAddModifyTaskPage(
            onSubmit: onSelected,
            task: task,
          ),
        ));
      },
      child: Row(
        children: [
          PopupMenuButton(
            tooltip: "Set Status",
            color: Colors.white,
            icon: statusIcon,
            onSelected: (value) async {
              await ToDoListHiveFunctions.modifyTask(task['key'], {...task, 'status': value});
              onSelected();
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: TaskStatus.active.index,
                child: const ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.circle,
                    color: Colors.green,
                    size: 18,
                  ),
                  title: Text("Active"),
                ),
              ),
              PopupMenuItem(
                value: TaskStatus.inProgress.index,
                child: const ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 18,
                  ),
                  title: Text("In Progress"),
                ),
              ),
              PopupMenuItem(
                value: TaskStatus.done.index,
                child: const ListTile(
                  dense: true,
                  leading: Icon(
                    Icons.circle,
                    color: Colors.blue,
                    size: 18,
                  ),
                  title: Text("Done"),
                ),
              ),
            ],
          ),
          Text(task['task']),
        ],
      ),
    );
  }
}