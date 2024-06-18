import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/routinebuilder_page.dart";

class RoutineBuilderWidget extends StatelessWidget {
  const RoutineBuilderWidget({super.key});

  Widget textInsideCircle({required String text, bool? filled}) {
    return Container(
      decoration: ShapeDecoration(
        shape: const CircleBorder(
          side: BorderSide(
            strokeAlign: BorderSide.strokeAlignInside,
            color: Colors.white,
            width: 1,
          ),
        ),
        color: filled == true ? Colors.white : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: TextStyle(
            color: filled == true ? Colors.indigo : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "Routine Builder",
      backgroundColor: Colors.indigo,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const RoutineBuilderPage(),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textInsideCircle(text: "Sun"),
              textInsideCircle(text: "Mon"),
              textInsideCircle(text: "Tue", filled: true),
              textInsideCircle(text: "Wed"),
              textInsideCircle(text: "Thu"),
              textInsideCircle(text: "Fri"),
              textInsideCircle(text: "Sat"),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            children: [
              Icon(
                // Icons.note_alt_outlined, // Subject
                Icons.refresh, // Routine
                color: Colors.white,
                size: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Routine",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Studying",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      "1:00 PM - 3:00 PM",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}