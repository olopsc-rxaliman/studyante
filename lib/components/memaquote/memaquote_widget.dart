import "dart:math";
import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";

final List<String> memaQuotes = [
  "Kumusta ka, Studyante?",
  "Kakayanin mo 'to! Ikaw pa?",
  "Keri pa ba today? Keri yan!",
  "Go lang nang go, besh!",
  "Nawa'y sumakses ang iyong efforts",
  "\"A person who thinks all the time has nothing to think about except thoughts.\" (Alan Watts)",
];

class MemaQuoteWidget extends StatelessWidget {
  const MemaQuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      backgroundColor: Colors.deepOrange,
      title: "Memaquote",
      child: Row(
        children: [
          const Icon(
            Icons.format_quote,
            color: Colors.white,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              memaQuotes[Random().nextInt(memaQuotes.length)],
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
