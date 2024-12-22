import "package:flutter/material.dart";
import "package:studyante/hive/hive_constants.dart";

class RoutineBuilderTabView extends StatelessWidget {
  final List routineList;

  const RoutineBuilderTabView({
    super.key,
    required this.routineList,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(5.0),
        itemCount: routineList.length,
        itemBuilder: (context, index) {
          // Error occurs here since routineList is empty
          // print("ROUTINE: $routineList");
          Map routine = routineList[index];

          return Card(
            color: routine['name'] == "Gold" ? Colors.yellow : Colors.white,
            child: ListTile(
              leading: Icon(
                routine['type'] == RoutineType.misc.index
                    ? Icons.refresh
                    : routine['type'] == RoutineType.school.index
                        ? Icons.note_alt_outlined
                        : routine['type'] == RoutineType.home.index
                            ? Icons.home
                            : Icons.question_mark,
                color: Colors.black,
              ),
              title: Text(routine['name']),
              subtitle: Text("${routine['startTime']} - ${routine['endTime']}"),
            ),
          );
        });
  }
}
