import 'package:flutter/material.dart';
import 'package:sflashy_ui/sflashy_ui.dart';

class TextRollerExample extends StatelessWidget {
  const TextRollerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: TextRoller(
        strings: [
          'Text Number One',
          'Second text to display',
          'Number 3',
          '4',
        ],
        wait: 1, // Same as waitDuration: Duration(seconds: 4)
        transition: 1, // Same as transitionDuration: Duration(seconds: 4)
        /// For better time flexibility:
        // waitDuration: Duration(milliseconds: 4500)
        // transitionDuration: Duration(milliseconds: 2500)
      ),
    );
  }
}
