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
      onTap: () => showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close),
                          tooltip: "Close",
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ToDoListAddModifyTaskPage(
                                  task: task,
                                  onSubmit: onSelected,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          tooltip: "Edit",
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['task'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                "Status: ",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                task['status'] == TaskStatus.active.index ? "Active"
                                : task['status'] == TaskStatus.done.index ? "Done"
                                : task['status'] == TaskStatus.inProgress.index ? "In progress"
                                : "N/A",
                                style: TextStyle(
                                  color: task['status'] == TaskStatus.active.index ? Colors.green
                                  : task['status'] == TaskStatus.done.index ? Colors.blue
                                  : task['status'] == TaskStatus.inProgress.index ? Colors.red
                                  : Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          task['description'] != ''
                          ? Text(
                            task['description'],
                            style: const TextStyle(fontSize: 16),
                          )
                          : const Text(
                            "No description provided",
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.black38,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      child: ListTile(
        titleAlignment: ListTileTitleAlignment.titleHeight,
        leading: PopupMenuButton(
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
        title: Text(task['task']),
        contentPadding: const EdgeInsets.only(
          left: 5,
          right: 18,
        ),
        horizontalTitleGap: 5,
      ),
    );
  }
}