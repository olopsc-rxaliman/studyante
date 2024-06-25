import "package:hive_flutter/hive_flutter.dart";
import "package:studyante/hive/hive_constants.dart";

class RoutineBuilderHiveFunctions {
  static final routineBuilderBox = Hive.box(routineListBoxName);

  // Add
  static Future<void> addRoutine({
    required String name,
    required String type,
    required Map scheduleEvery,
    required String startTime,
    required String endTime,
  }) => routineBuilderBox.add({
    'name': name,
    'type': type,
    'scheduleEvery': scheduleEvery,
    'startTime': startTime,
    'endTime': endTime,
  });

  // Retrieve
  static List getAllRoutines() => routineBuilderBox.keys.map((key) {
    final data = routineBuilderBox.get(key);
    return {
      ...data,
      'key': key,
    };
  }).toList();
  static List getRoutinesFrom({
    required String dayOfWeek,
  }) => routineBuilderBox.keys.where(
    (key) => routineBuilderBox.get(key)['scheduleEvery'][dayOfWeek] == true
  ).toList();

  // Update

  // Delete
  static Future<void> deleteAllRoutines() => routineBuilderBox.deleteAll(routineBuilderBox.keys);
}