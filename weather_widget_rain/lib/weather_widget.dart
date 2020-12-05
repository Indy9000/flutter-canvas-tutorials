import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'my_canvas.dart';
import 'particle.dart';

class WeatherWidget extends StatefulWidget {
  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

var rng = Random();

class _WeatherWidgetState extends State<WeatherWidget> {
  var particles = new List<Particle>();
  Timer timer;

  @override
  void initState() {
    super.initState();
    var xx = 0.0;
    for (var i = 0; i < 15; i++) {
      xx += (6.0 + rng.nextDouble() * 6.0);
      var dx = xx;
      var dy = -rng.nextDouble() * 50.0;
      var r = 15.0 + rng.nextDouble() * 15.0;
      var s = 1.0 + rng.nextDouble() * 5.0;
      particles.add(Particle()
        ..o = Offset(dx, dy)
        ..p = Offset(dx, dy)
        ..s = s
        ..r = r);
    }

    // setup animation timer and update variable
    final fps = 50.0;
    var frameDuration = (1000 ~/ fps);
    timer = Timer.periodic(Duration(milliseconds: frameDuration), (timer) {
      setState(() {
        particles.forEach((p) {
          p.p += Offset(0, p.s);
          if (p.p.dy > 100) {
            p.p = p.o;
          }
        });
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
        painter: MyCanvas(particles),
      ),
    );
  }
}
