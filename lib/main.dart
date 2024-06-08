import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:studyante/hive/hive_constants.dart';
import 'package:studyante/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(todoListBoxName);
  runApp(const StudyanteApp());
}

class StudyanteApp extends StatelessWidget {
  const StudyanteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Studyante",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}