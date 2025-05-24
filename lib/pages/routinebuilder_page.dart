import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:studyante/components/routinebuilder/routinebuilder_add_modify_routine.dart";
import "package:studyante/components/routinebuilder/routinebuilder_tabview.dart";
import "package:studyante/services/hive/hive_routinebuilder_functions.dart";

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
    print("ROUTINES: ${RoutineBuilderHiveFunctions.getAllRoutines()}");

    int dayOfWeekIndex = dayOfWeekAbbr.indexOf(currentDayOfWeekAbbr);

    return DefaultTabController(
      initialIndex: dayOfWeekIndex,
      length: 7,
      child: Scaffold(
        backgroundColor: Colors.indigo,
        resizeToAvoidBottomInset: false,
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
          actions: [
            IconButton(
              onPressed: () async {
                await RoutineBuilderHiveFunctions.deleteAllRoutines();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Deleted all routines"))
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
          ],
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
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
          children: [
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'sunday')),
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'monday')),
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'tuesday')),
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'wednesday')),
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'thursday')),
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'friday')),
            RoutineBuilderTabView(routineList: RoutineBuilderHiveFunctions.getRoutinesFrom(dayOfWeek: 'saturday')),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.white,
          icon: const Icon(
            Icons.add,
            color: Colors.black,
          ),
          label: const Text(
            "Add Routine",
            style: TextStyle(color: Colors.black),
          ),
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