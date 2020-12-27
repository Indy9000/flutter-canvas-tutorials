import 'dart:math';

import 'package:christmas_card/greeting_widget.dart';
import 'package:flutter/material.dart';

class GreetingPainter extends CustomPainter {
  final List<Particle> particles;
  GreetingPainter(this.particles);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    drawBackground(canvas, size);
    final center = Offset(size.width / 2, size.height / 2);
    drawFrame(canvas, center);
    drawParticles(canvas, center);
    drawText(canvas, center);
  }

  final W = 600.0;
  void drawFrame(Canvas canvas, Offset center) {
    final rect = Rect.fromCenter(center: center, width: W, height: W);
    final border = Paint()
      ..color = Color(0xff01182b)
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(rect, border);
  }

  void drawBackground(Canvas canvas, Size size) {
    var gradient = RadialGradient(
      center: Alignment(-W / size.width + 0.2, W / size.height - 0.2),
      radius: 1.0,
      colors: [Color(0xffa60112), Color(0xff01182b)],
      stops: [0.0, 1.0],
    );
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }

  final b1 = Paint()
    ..color = Colors.red
    ..strokeWidth = 3.0
    ..style = PaintingStyle.fill;

  final b2 = Paint()
    ..color = Color(0xff0b3720)
    ..strokeWidth = 3.0
    ..style = PaintingStyle.fill;

  final List<Color> light_cols = [
    Color(0xffffbe0b),
    Color(0xfffb5607),
    Color(0xffff006e),
    Color(0xff8338ec),
    Color(0xff3a86ff)
  ];

  var rng = Random();
  void drawParticles(Canvas canvas, Offset center) {
    if (particles == null) return;
    var F = center + Offset(0, 100.0);
    final w = 5.0;
    for (var i = 0; i < particles.length; i++) {
      final p = particles[i];
      final Fd = F - Offset(0, 10.0 * i);
      for (var j = 0; j < p.points.length; j++) {
        b1.color = light_cols[rng.nextInt(light_cols.length)];
        b2.color = p.colour;
        canvas.drawCircle(p.points[j] + Fd, w, b1);
        canvas.drawLine(Fd, p.points[j] + Fd, b2);
      }
    }
  }

  final textStyle =
      TextStyle(color: Colors.red, fontFamily: "Rochester", fontSize: 80);
  void drawText(Canvas canvas, Offset center) {
    final textSpan = TextSpan(text: "Merry Christmas", style: textStyle);
    final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    textPainter.layout(minWidth: 0, maxWidth: W);
    final padding = 10.0;
    final offset = Offset(center.dx - textPainter.width / 2.0,
        center.dy + W / 2.0 - textPainter.height - padding);
    textPainter.paint(canvas, offset);
  }
}
