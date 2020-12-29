import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'data.dart';
import 'timeline_painter.dart';
import 'dart:ui' as ui;

class TimelineWidget extends StatefulWidget {
  @override
  _TimelineWidgetState createState() => _TimelineWidgetState();
}

class _TimelineWidgetState extends State<TimelineWidget> {
  var start = DateTime.utc(2020, 1, 1);
  var end = DateTime.utc(2021, 1, 1);
  ui.Image img;
  @override
  void initState() {
    super.initState();

    rootBundle.load("assets/fireworks.jpg").then((bd) {
      decodeImageFromList(bd.buffer.asUint8List()).then((img) {
        setState(() {
          this.img = img;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final dc = GenerateDummyData();
    final dc = GenerateWorldEvents();
    return Container(
      child: GestureDetector(
        onHorizontalDragUpdate: handleHDragUpdate,
        child: CustomPaint(
          child: Container(),
          painter: TimelinePainter(start, end, dc, img),
        ),
      ),
    );
  }

  void handleHDragUpdate(DragUpdateDetails d) {
    // print(
    //     "Drag update [${d.sourceTimeStamp}] pd=${d.primaryDelta} d=${d.delta}");

    final dd = d.primaryDelta;
    setState(() {
      start = start.add(Duration(days: -dd.toInt()));
      end = end.add(Duration(days: -dd.toInt()));
    });
  }
}
