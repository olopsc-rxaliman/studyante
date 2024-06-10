import "dart:async";

import "package:intl/intl.dart";
import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/datetime_page.dart";

class DateTimeWidget extends StatelessWidget {
  const DateTimeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 500)),
      builder: (context, snapshot) {
        DateTime today = DateTime.now();
        String formattedDate = DateFormat("E, MMM d, y").format(today); // Wed, Jun 5, 2024
        String formattedTime = DateFormat("jm").format(today); // 1:00 PM
        
        return BaseWidget(
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const DateTimePage();
              }
            ));
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Wrap(
              direction: Axis.horizontal,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 40,
              runSpacing: 5,
              children: [
                IntrinsicWidth(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            formattedDate,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IntrinsicWidth(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Time",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white
                            ),
                          ),
                          Text(
                            formattedTime,
                            style: const TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}