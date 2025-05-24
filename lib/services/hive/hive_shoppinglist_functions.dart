import 'package:hive_flutter/hive_flutter.dart';
import 'package:studyante/services/hive/hive_constants.dart';

class ShoppingListHiveFunctions {
  static final shoppingListBox = Hive.box(shoppingListBoxName);

  // Add
  static Future<void> addItem({
    required String name,
  }) =>
      shoppingListBox.add({
        'name': name,
      });

  // Retrieve
  static List getAllItems() => shoppingListBox.keys.map((key) {
        final data = shoppingListBox.get(key);
        return {
          ...data,
          'key': key,
        };
      }).toList();

  // Delete
  static Future<void> deleteItem({
    required int key,
  }) =>
      shoppingListBox.delete(key);
  static Future<void> deleteAllItems() =>
      shoppingListBox.deleteAll(shoppingListBox.keys);
}
