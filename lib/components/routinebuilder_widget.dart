import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/routinebuilder_page.dart";

class RoutineBuilderWidget extends StatelessWidget {
  const RoutineBuilderWidget({super.key});

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
      child: const Padding(
        padding: EdgeInsets.only(bottom: 8),
        child: Wrap(
          alignment: WrapAlignment.start,
          spacing: 20,
          runSpacing: 10,
          children: [
            IntrinsicWidth(
              child: Row(
                children: [
                  Icon(
                    Icons.note_alt_outlined, // Subject
                    // Icons.refresh, // Routine
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Subject",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Science, Technology and Society",
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        Text(
                          "(Mon, Wed) 1:00 PM - 3:00 PM",
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
            ),
            IntrinsicWidth(
              child: Row(
                children: [
                  Icon(
                    Icons.keyboard_double_arrow_right,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "Rizal's Life, Works and Readings",
                          softWrap: false,
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "(Wed) 3:00 PM - 4:00 PM",
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
            ),
          ],
        ),
      ),
    );
  }
}