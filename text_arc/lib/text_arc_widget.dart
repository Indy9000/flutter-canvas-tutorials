import 'dart:async';

import 'package:flutter/material.dart';

import 'mypainter.dart';

class TextArcWidget extends StatefulWidget {
  @override
  _TextArcWidgetState createState() => _TextArcWidgetState();
}

class _TextArcWidgetState extends State<TextArcWidget> {
  Timer timer;
  double startAngle = 0.0;
  List<String> wordList = [
    "January",
    "February",
    "March",
    "Apocalypse",
    "May be",
    "Haha June",
    "Ofcourse July",
    "Ohgast",
    "Sceptember",
    "Octo tomb errr",
    "Never remember",
    "Diecember",
    "",
    "I can't believe",
    "We welcomed",
    "this with champagne ",
    "and fireworks!??",
    "",
    "Here's hoping",
    "for a better",
    "2021",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
    ".",
  ];
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 25), (_) {
      setState(() {
        startAngle -= 0.005;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        child: Container(),
        painter: MyPainter(startAngle, wordList),
      ),
    );
  }
}
