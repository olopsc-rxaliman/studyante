import "package:flutter/material.dart";

class JournotesPage extends StatefulWidget {
  const JournotesPage({super.key});

  @override
  State<JournotesPage> createState() => _JournotesPageState();
}

class _JournotesPageState extends State<JournotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "JOURNOTES",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}