import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/journotes_page.dart";

class JournotesWidget extends StatelessWidget {
  const JournotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      title: "Journotes",
      backgroundColor: Colors.deepPurple,
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const JournotesPage(),
        ),
      ),
      child: const Wrap(
        direction: Axis.horizontal,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 30,
        runSpacing: 5,
        children: [
          IntrinsicWidth(
            child: Row(
              children: [
                Icon(
                  Icons.library_books,
                  color: Colors.white,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notes",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "0",
                      style: TextStyle(
                        fontSize: 30,
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
    );
  }
}