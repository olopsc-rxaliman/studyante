import "package:flutter/material.dart";
import "package:studyante/hive/hive_constants.dart";

class RoutineBuilderAddModifyRoutinePage extends StatefulWidget {
  final Map? routine;

  const RoutineBuilderAddModifyRoutinePage({
    super.key,
    this.routine,
  });

  @override
  State<RoutineBuilderAddModifyRoutinePage> createState() => _RoutineBuilderAddModifyRoutinePageState();
}

class _RoutineBuilderAddModifyRoutinePageState extends State<RoutineBuilderAddModifyRoutinePage> {
  late final Map? routine;
  late final TextEditingController nameInputController;
  late final TextEditingController routineInputController;
  late final GlobalKey<FormState> formKey;
  late bool isErrorOnSchedule;
  var selectedTime;

  Map scheduleOn = {
    'sunday': false,
    'monday': false,
    'tuesday': false,
    'wednesday': false,
    'thursday': false,
    'friday': false,
    'saturday': false,
  };
  
  @override
  void initState() {
    super.initState();
    routine = widget.routine;
    nameInputController = TextEditingController();
    routineInputController = TextEditingController();
    formKey = GlobalKey<FormState>();
    isErrorOnSchedule = false;
  }

  @override
  void dispose() {
    nameInputController.dispose();
    routineInputController.dispose();
    super.dispose();
  }
  
  bool selectedAtleastOneDay() => scheduleOn.keys.where(
    (element) => scheduleOn[element] == true
  ).isNotEmpty;

  Widget textInsideCircle({required String text, required String dayOfWeek}) {
    return InkWell(
      customBorder: const CircleBorder(),
      splashFactory: InkRipple.splashFactory,
      borderRadius: BorderRadius.circular(10),
      highlightColor: Colors.black.withOpacity(0.05),
      splashColor: Colors.black.withOpacity(0.1),
      onTap: () {
        setState(() {
          scheduleOn[dayOfWeek] = !scheduleOn[dayOfWeek];
        });
      },
      child: Ink(
        decoration: ShapeDecoration(
          shape: CircleBorder(
            side: BorderSide(
              strokeAlign: BorderSide.strokeAlignInside,
              color: scheduleOn[dayOfWeek] == true ? Colors.transparent : Colors.black,
              width: 1.2,
            ),
          ),
          color: scheduleOn[dayOfWeek] == true ? Colors.indigo : null,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
              color: scheduleOn[dayOfWeek] == true ? Colors.white : Colors.black,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          setState(() {
            isErrorOnSchedule = !selectedAtleastOneDay();
          });
          if (formKey.currentState!.validate()) {
            if (isErrorOnSchedule == false) {
              print("Accepted");
            }
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
                autofocus: false,
                textInputAction: TextInputAction.done,
                onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
                validator: (value) {
                  if (value == null || value.toString().isEmpty) return "This field is required";
                  return null;
                },
              ),
              const SizedBox(height: 20.0),
              DropdownMenu(
                controller: routineInputController,
                menuStyle: const MenuStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
                  padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 12)),
                ),
                expandedInsets: EdgeInsets.zero,
                label: const Text(
                  "Time",
                  style: TextStyle(color: Colors.black),
                ),
                initialSelection: RoutineType.misc,
                dropdownMenuEntries: const [
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
              const SizedBox(height: 20.0),
              InputDecorator(
                decoration: InputDecoration(
                  label: const Text(
                    "Schedule every",
                    style: TextStyle(color: Colors.black),
                  ),
                  border: const OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red.shade900,
                      width: 1,
                    ),
                  ),
                  errorText: isErrorOnSchedule ? "Select at least one day in a week" : null,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textInsideCircle(text: "Sun", dayOfWeek: 'sunday'),
                    textInsideCircle(text: "Mon", dayOfWeek: 'monday'),
                    textInsideCircle(text: "Tue", dayOfWeek: 'tuesday'),
                    textInsideCircle(text: "Wed", dayOfWeek: 'wednesday'),
                    textInsideCircle(text: "Thu", dayOfWeek: 'thursday'),
                    textInsideCircle(text: "Fri", dayOfWeek: 'friday'),
                    textInsideCircle(text: "Sat", dayOfWeek: 'saturday'),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(
                    "Time",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                child: ListTile(
                  minTileHeight: 30,
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  horizontalTitleGap: 10,
                  title: const Text("--:--"),
                  leading: IconButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => TimePickerDialog(
                          initialTime: TimeOfDay.now(),    
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.watch_later,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}