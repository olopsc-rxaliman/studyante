import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:studyante/components/routinebuilder_add_modify_routine.dart";
import "package:studyante/components/routinebuilder_tabview.dart";
import "package:studyante/hive/hive_constants.dart";

class RoutineBuilderPage extends StatefulWidget {
  const RoutineBuilderPage({super.key});

  @override
  State<RoutineBuilderPage> createState() => _RoutineBuilderPageState();
}

class _RoutineBuilderPageState extends State<RoutineBuilderPage> {
  final String currentDayOfWeekAbbr = DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime.now());
  final List dayOfWeekAbbr = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];

  Widget tabDisplay({required String text, required bool highlighted}) => Tab(
    icon: highlighted == true ? Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 10.0,
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.indigo),
        ),
      ),
    )
    : Text(text),
  );

  @override
  Widget build(BuildContext context) {
    int dayOfWeekIndex = dayOfWeekAbbr.indexOf(currentDayOfWeekAbbr);

    return DefaultTabController(
      initialIndex: dayOfWeekIndex,
      length: 7,
      child: Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "ROUTINE BUILDER",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: List.generate(
              7,
              (index) => tabDisplay(
                text: dayOfWeekAbbr[index],
                highlighted: dayOfWeekAbbr[index] == currentDayOfWeekAbbr
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(
            7,
            (index) => RoutineBuilderTabView(
            routineList: [
              {'name': "Routine 5", 'time': "9:00am - 10:00am", 'type': RoutineType.misc.index},
              {'name': "Routine 1", 'time': "9:00am - 10:00am", 'type': RoutineType.misc.index},
              {'name': "Routine 2", 'time': "9:00am - 10:00am", 'type': RoutineType.school.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 4", 'time': "9:00am - 10:00am", 'type': RoutineType.misc.index},
              {'name': "Routine 2", 'time': "9:00am - 10:00am", 'type': RoutineType.school.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 2", 'time': "9:00am - 10:00am", 'type': RoutineType.school.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
              {'name': "Routine 2", 'time': "9:00am - 10:00am", 'type': RoutineType.school.index},
              {'name': "Routine 3", 'time': "9:00am - 10:00am", 'type': RoutineType.home.index},
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          icon: const Icon(Icons.add),
          label: const Text("Add Routine"),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RoutineBuilderAddModifyRoutinePage(),
            ),
          ),
        ),
      ),
    );
  }
}