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
          title: "Date & Time",
          backgroundColor: Colors.teal,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const DateTimePage();
              }
            ));
          },
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
                    Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white
                      ),
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
                    Text(
                      formattedTime,
                      style: const TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}