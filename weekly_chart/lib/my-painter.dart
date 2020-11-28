import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'my-canvas.dart';

class MyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

var weekData = List<double>();
var rng = Random();
Timer timer;
var percentage = 0.0;
var totalAnimDuration = 1.0; // in s
var fps = 50.0;
var minD = double.maxFinite;
var maxD = -double.maxFinite;
var rangeD = 1.0;

class _MyPainterState extends State<MyPainter> {
  @override
  void initState() {
    super.initState();
    // generate data
    for (var i = 0; i < 7; i++) {
      var d = rng.nextDouble() * 100.0;
      weekData.add(d);
      minD = d < minD ? d : minD;
      maxD = d > maxD ? d : maxD;
    }
    rangeD = maxD - minD;

    // set up animation timer and update variables
    var frameDuration = (1000 ~/ fps);
    var percentStep = 1.0 / (totalAnimDuration * fps);
    timer = Timer.periodic(Duration(milliseconds: frameDuration), (Timer _) {
      // Update animation
      setState(() {
        percentage += percentStep;
        percentage = percentage > 1.0 ? 1.0 : percentage;
        if (percentage >= 1.0) {
          timer.cancel();
        }
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
    return Scaffold(
      body: CustomPaint(
        child: Container(),
        painter: MyCanvas(weekData, minD, maxD, rangeD, percentage),
      ),
    );
  }
}
