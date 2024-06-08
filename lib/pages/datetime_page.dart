import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:intl/intl.dart";

class DateTimePage extends StatefulWidget {
  const DateTimePage({super.key});

  @override
  State<DateTimePage> createState() => _DateTimePageState();
}

class _DateTimePageState extends State<DateTimePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: []
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom
      ]
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool displayMilitaryTime = false;

    return Scaffold(
      backgroundColor: const Color(0xFF1C2120),
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(milliseconds: 100)),
        builder: (context, snapshot) {
          DateTime today = DateTime.now();
          String weekDay = DateFormat("EEEE").format(today);
          String date = DateFormat("MMMM d, y").format(today);
          String time = DateFormat("jm").format(today);
          String militaryTime = DateFormat("Hms").format(today);

          return Center(
            child: IntrinsicWidth(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        weekDay,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      displayMilitaryTime = !displayMilitaryTime;
                    },
                    child: Text(
                      displayMilitaryTime ? militaryTime : time,
                      style: const TextStyle(
                        fontSize: 140,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}