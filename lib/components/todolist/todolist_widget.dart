import "dart:async";

import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/services/hive/hive_todolist_functions.dart";
import "package:studyante/pages/todolist_page.dart";

class ToDoListWidget extends StatelessWidget {
  final Color widgetColor;
  final bool navigateOnClick;
  final String? title;

  const ToDoListWidget({
    super.key,
    required this.widgetColor,
    required this.navigateOnClick,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 500)),
      builder: (context, snapshot) {
        Map todoListSummary = ToDoListHiveFunctions.getSummary();
        return BaseWidget(
          title: title,
          backgroundColor: widgetColor,
          onTap: navigateOnClick
              ? () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const ToDoListPage();
                  }));
                }
              : null,
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 30,
            runSpacing: 5,
            children: [
              IntrinsicWidth(
                child: Row(
                  children: [
                    width > 390
                        ? const Icon(
                            Icons.add_task,
                            color: Colors.black,
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            width <= 390
                                ? const Padding(
                                    padding: EdgeInsets.only(right: 4),
                                    child: Icon(
                                      Icons.add_task,
                                      color: Colors.black,
                                      size: 12,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const Text(
                              "Tasks",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                        Text(
                          "${todoListSummary['taskCount']}",
                          style: const TextStyle(
                              fontSize: 30, color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IntrinsicWidth(
                child: Row(
                  children: [
                    Row(
                      children: [
                        width > 390
                            ? const Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 18,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                width <= 390
                                    ? const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.green,
                                          size: 8,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const Text(
                                  "Active",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              "${todoListSummary['activeCount']}",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        width > 390
                            ? const Icon(
                                Icons.circle,
                                color: Colors.blue,
                                size: 18,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                width <= 390
                                    ? const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.blue,
                                          size: 8,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const Text(
                                  "Done",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              "${todoListSummary['doneCount']}",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(
                      children: [
                        width > 390
                            ? const Icon(
                                Icons.circle,
                                color: Colors.red,
                                size: 18,
                              )
                            : const SizedBox.shrink(),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                width <= 390
                                    ? const Padding(
                                        padding: EdgeInsets.only(right: 4),
                                        child: Icon(
                                          Icons.circle,
                                          color: Colors.red,
                                          size: 8,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const Text(
                                  "In progress",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black),
                                ),
                              ],
                            ),
                            Text(
                              "${todoListSummary['inProgressCount']}",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
