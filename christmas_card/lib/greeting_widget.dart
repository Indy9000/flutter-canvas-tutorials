import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import 'greeting_painter.dart';

class GreetingWidget extends StatefulWidget {
  @override
  _GreetingWidgetState createState() => _GreetingWidgetState();
}

class Particle {
  List<Offset> points;
  double radius1;
  double radius2;
  double speed;
  double angle;
  Color colour;
}

final List<Color> green_cols = [
  Color(0xff27a300),
  Color(0xff2a850e),
  Color(0xff2d661b),
  Color(0xff005c00)
];

class _GreetingWidgetState extends State<GreetingWidget> {
  var particles = new List<Particle>();
  Timer timer;
  @override
  void initState() {
    super.initState();
    final n = makeParticles();
    timer = Timer.periodic(Duration(milliseconds: 40), (_) {
      // update particles.
      final rad = pi / 180.0;
      final radD = 360.0 / n * rad;
      var k = 0;
      setState(() {
        particles.forEach((p) {
          p.angle += p.speed * rad;
          for (var k = 0; k < p.points.length; k++) {
            p.points[k] = Offset(p.radius1 * cos(p.angle + k * radD),
                p.radius2 * sin(p.angle + k * radD));
          }
        }); // foreach
      }); // setState
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  final rng = Random();
  static const int Count = 25;
  static const int Edges = 24;
  int makeParticles() {
    final R1 = 150.0;
    final R2 = 100.0;
    final r = R1 / Count;
    for (var i = 0; i < Count; i++) {
      var p = Particle()
        ..angle = 0.0
        ..radius1 = R1 - r * i
        ..radius2 = R2 - r * i
        ..colour = green_cols[rng.nextInt(green_cols.length)]
        ..speed = (i + 1) * 0.2;
      p.points = Iterable.generate(Edges, (_) => Offset(0, 0)).toList();

      particles.add(p);
    }
    return Edges;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: CustomPaint(
          child: Container(),
          painter: GreetingPainter(particles),
        ));
  }
}
