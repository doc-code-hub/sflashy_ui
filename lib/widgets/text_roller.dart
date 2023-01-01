import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sflashy_ui/functions/merge_strings.dart';

class TextRoller extends StatefulWidget {
  ///
  final List<String> strings;
  final Duration? waitDuration;
  final Duration? transitionDuration;
  final int? wait;
  final int? transition;
  final TextStyle? style;

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
  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;

  bool disposed = false;

  int _currentIndex = 0;

  final timers = [];

  statusListener(status) {
    if (status == AnimationStatus.completed) {
      timers.add(
        Timer(
            widget.waitDuration ?? Duration(seconds: widget.wait ?? 5),
            () => {
                  if (_animationController.status != AnimationStatus.completed)
                    {
                      setState(() {
                        _currentIndex =
                            (_currentIndex + 1) % widget.strings.length;
                        _animationController.reset();
                        _animationController.forward();
                      })
                    }
                }),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.transitionDuration ??
          Duration(seconds: widget.transition ?? 1),
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOutCubicEmphasized,
    );
    _animationController.addStatusListener(statusListener);
    timers.add(Timer(widget.waitDuration ?? Duration(seconds: widget.wait ?? 5),
        () => {_animationController.forward()}));
  }

  @override
  void dispose() {
    _animationController.removeStatusListener(statusListener);
    timers.map((timer) => timer.cancel());
    disposed = true;
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
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
