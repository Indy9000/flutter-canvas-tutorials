import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'particle.dart';

class MyCanvas extends CustomPainter {
  final List<Particle> particles;
  MyCanvas(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    var p = Paint()..color = Colors.red;
    canvas.drawPaint(p);
    var titleStyle = TextStyle(
        color: Colors.black,
        fontSize: 150,
        fontWeight: FontWeight.normal,
        fontFamily: "Oswald");
    var unitStyle = TextStyle(
        color: Colors.black,
        fontSize: 50,
        fontWeight: FontWeight.w100,
        fontFamily: "Oswald");
    var normalTextStyle = TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.w400,
    );

    var center = Offset(size.width / 2, size.height / 2);
    drawFrame(canvas, center);
    drawTemp(canvas, center, titleStyle, unitStyle);
    drawCondition(canvas, center, normalTextStyle);
    drawPlace(canvas, center, normalTextStyle);
    drawClouds(canvas, center);
    drawRain(canvas, center);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double W = 600.0;
  void drawFrame(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: W, height: W);
    var border = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawRect(rect, border);
  }

  var dy = 0.0;
  void drawTemp(Canvas canvas, Offset center, TextStyle ts, TextStyle ts1) {
    var offset = 10.0;
    var left = offset + center.dx - W / 2.0;
    var top = offset + center.dy - W / 2.0;
    var rect = Rect.fromLTWH(left, top, W / 4.0, W / 4.0);
    var border = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    // canvas.drawRect(rect, border);

    var s = "°c";
    canvas.save();
    canvas.clipRect(rect);
    var w1 = drawHText(canvas, rect.topLeft, rect.width / 2, ts, "1");
    // dy -= 20.0;
    var digit_offset = Offset(w1, dy);

    var w2 =
        drawHText(canvas, rect.topLeft + digit_offset, rect.width / 2, ts, "2");
    digit_offset = Offset(w1 + w2, 30);
    canvas.restore();
    drawHText(canvas, rect.topLeft + digit_offset, 20, ts1, s);
  }

  // draw horizontal text left aligned and with y offset
  double drawHText(Canvas canvas, Offset position, double width,
      TextStyle style, String text) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: width);
    Offset drawPosition =
        Offset(position.dx, position.dy - (textPainter.height / 5));
    textPainter.paint(canvas, drawPosition);
    return textPainter.width;
  }

  // draw horizontal text centered around position
  double drawHText1(Canvas canvas, Offset position, double width,
      TextStyle style, String text) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: width);
    Offset drawPosition =
        Offset(position.dx - textPainter.width / 2.0, position.dy);
    textPainter.paint(canvas, drawPosition);
    return textPainter.width;
  }

  double drawVText(Canvas canvas, Offset position, double width,
      TextStyle style, String text) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter = TextPainter(
        text: textSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: width);

    Offset drawPosition =
        Offset(position.dx, position.dy - (textPainter.height / 2));
    textPainter.paint(canvas, drawPosition);
    return textPainter.width;
  }

  void drawCondition(Canvas canvas, Offset center, TextStyle ts) {
    var ww = 50;
    var pos = center + Offset(W / 2.0 - ww, 0);
    var s = "RAINY";
    drawVText(canvas, pos, 10.0, ts, s);
  }

  void drawPlace(Canvas canvas, Offset center, TextStyle ts) {
    var ww = 50;
    var pos = center + Offset(0, W / 2.0 - ww);
    var s = "TOKYO";
    drawHText1(canvas, pos, W, ts, s);
  }

  void drawClouds(Canvas canvas, Offset center) {
    var cloud = Paint()
      ..color = Color(0xff555555)
      ..style = PaintingStyle.fill;

    var p1 = Offset(-50, -30) + center;
    var r1 = 30.0;
    canvas.drawCircle(p1, r1, cloud);

    var p2 = Offset(-10, -50) + center;
    var r2 = 40.0;
    canvas.drawCircle(p2, r2, cloud);

    var p3 = Offset(10, -10) + center;
    var r3 = 50.0;
    canvas.drawCircle(p3, r3, cloud);

    var p4 = Offset(50, -30) + center;
    var r4 = 50.0;
    canvas.drawCircle(p4, r4, cloud);

    var p5 = Offset(100, -10) + center;
    var r5 = 20.0;
    canvas.drawCircle(p5, r5, cloud);
  }

  void drawRain(Canvas canvas, Offset center) {
    var rain = Paint()
      ..color = Colors.black
      ..strokeWidth = 5.0
      ..style = PaintingStyle.stroke;
    var rect = Rect.fromCenter(center: center, width: 150, height: 150);

    canvas.clipRect(rect);
    canvas.save();
    canvas.translate(W - 50, -120);
    canvas.rotate(45.0 * pi / 180);

    particles.forEach((p) {
      var p2 = p.p + Offset(0, p.r);
      var dd = Offset(-50.0, 0);
      canvas.drawLine(p.p + center + dd, p2 + center + dd, rain);
    });
    canvas.restore();
  }
}
