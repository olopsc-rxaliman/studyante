import "package:hive_flutter/hive_flutter.dart";
import "package:studyante/services/hive/hive_constants.dart";

class ToDoListHiveFunctions {
  static final todoListBox = Hive.box(todoListBoxName);

  // Add
  static Future<void> addTask({
    required String task,
    required String description,
    required String timestamp,
  }) => todoListBox.add({
    'task': task,
    'description': description,
    'timestamp': timestamp,
    'status': TaskStatus.active.index,
  });

  // Retrieve
  static Map getSummary() => {
    'taskCount': todoListBox.length,
    'activeCount': todoListBox.values.where((item) => item['status'] == TaskStatus.active.index).length,
    'doneCount': todoListBox.values.where((item) => item['status'] == TaskStatus.done.index).length,
    'inProgressCount': todoListBox.values.where((item) => item['status'] == TaskStatus.inProgress.index).length,
  };
  static List getAllTasks() => todoListBox.keys.map((key) {
    final data = todoListBox.get(key);
    return {
      ...data,
      'key': key,
    };
  }).toList();
  static Map getTask(int key) => todoListBox.get(key);

  // Update
  static Future<void> modifyTask(int key, Map data) => todoListBox.put(key, data);

  // Delete
  static Future<void> deleteTask(int key) => todoListBox.delete(key);
  static Future<void> deleteTheseTasks(List keys) => todoListBox.deleteAll(keys);
  static Future<void> deleteAllTasks() => todoListBox.deleteAll(todoListBox.keys);
}