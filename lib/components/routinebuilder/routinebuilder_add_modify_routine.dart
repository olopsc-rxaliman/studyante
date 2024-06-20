import "package:flutter/material.dart";
import "package:studyante/hive/hive_constants.dart";

class RoutineBuilderAddModifyRoutinePage extends StatelessWidget {
  final Map? routine;

  const RoutineBuilderAddModifyRoutinePage({
    super.key,
    this.routine,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController nameInputController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: Text(
          routine == null ? "Add Routine" : "Modify Routine",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          if (formKey.currentState!.validate()) {
            // TODO: Implement submission of routine
          }
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
        ),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameInputController,
                cursorColor: Colors.black,
                decoration: const InputDecoration(
                  label: Text(
                    "Name",
                    style: TextStyle(color: Colors.black),
                  ),
                  border: OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2,
                    )
                  ),
                ),
                autofocus: true,
                textInputAction: TextInputAction.next,
                validator: (value) {
                  if (value == null || value.toString().isEmpty) return "This field is required";
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              const DropdownMenu(
                menuStyle: MenuStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
                ),
                expandedInsets: EdgeInsets.zero,
                label: Text("Type"),
                initialSelection: RoutineType.misc,
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                    value: RoutineType.misc,
                    leadingIcon: Icon(Icons.refresh),
                    label: "Routine",
                  ),
                  DropdownMenuEntry(
                    value: RoutineType.school,
                    leadingIcon: Icon(Icons.note_alt_outlined),
                    label: "School Schedule",
                  ),
                  DropdownMenuEntry(
                    value: RoutineType.home,
                    leadingIcon: Icon(Icons.home),
                    label: "House Chore",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}