import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sflashy_ui/functions/merge_strings.dart';

class TextRoller extends StatefulWidget {
  /// List of strings to merge in transitions
  final List<String> strings;

  /// Duration to wait before starting the next transition
  final Duration? waitDuration;

  /// Duration of the transition (gradual merge) between strings
  final Duration? transitionDuration;

  /// Shortcut `int` for specify waitDuration in seconds
  final int? wait;

  /// Shortcut `int` for specify transitionDuration in seconds
  final int? transition;

  /// TextStyle of the Text rendered
  final TextStyle? style;

  /// Strings merge transition in an infinite loop animation
  const TextRoller({
    Key? key,
    required this.strings,
    this.waitDuration,
    this.transitionDuration,
    this.wait,
    this.transition,
    this.style,
  }) : super(key: key);

  @override
  TextRollerState createState() => TextRollerState();
}

class TextRollerState extends State<TextRoller>
    with SingleTickerProviderStateMixin {
  /// Text animation controller
  late AnimationController _animationController;

  /// Curved animation
  late CurvedAnimation _curvedAnimation;

  /// Current string index
  int _currentIndex = 0;

  // Timers to eventually cancel on dispose
  final timers = [];

  statusListener(status) {
    if (status == AnimationStatus.completed) {
      timers.add(
        Timer(
          widget.waitDuration ?? Duration(seconds: widget.wait ?? 5),
          () => {
            setState(() {
              _currentIndex = (_currentIndex + 1) % widget.strings.length;
              _animationController.reset();
              _animationController.forward();
            })
          },
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    // Init Animation Controller
    _animationController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration ??
          Duration(seconds: widget.transition ?? 1),
    );

    // Specify Animation Curve
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubicEmphasized,
    );

    // Add animation status listener
    _animationController.addStatusListener(statusListener);

    // Initial transition timer
    timers.add(Timer(widget.waitDuration ?? Duration(seconds: widget.wait ?? 5),
        () => {_animationController.forward()}));
  }

  @override
  void dispose() {
    super.dispose();

    // Remove animation status listener
    _animationController.removeStatusListener(statusListener);

    // Cancel every timer
    timers.map((timer) => timer.cancel());

    // Dispose animation controller
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        // Get the current string
        String text = mergeStrings(
            widget.strings[_currentIndex],
            widget.strings[(_currentIndex + 1) % widget.strings.length],
            _curvedAnimation.value);

        return Text(
          text,
          style: widget.style,
        );
      },
    );
  }
}
