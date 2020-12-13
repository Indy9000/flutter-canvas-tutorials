import 'dart:math';

import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final double startAngle; // startAngle of slanted text in radians
  final List<String> wordList;
  MyPainter(this.startAngle, this.wordList);

  final style1 = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 60.0,
  );
  final style2 = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 110.0,
  );
  final style3 = TextStyle(
    color: Color(0xffd2495b),
    fontSize: 50.0,
    fontWeight: FontWeight.bold,
  );

  final arcStyle1 = Paint()
    ..color = Color(0xffd6b357)
    ..strokeWidth = 70.0
    ..style = PaintingStyle.stroke;

  final arcStyle2 = Paint()
    ..color = Colors.black
    ..strokeWidth = 100.0
    ..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.drawPaint(Paint()..color = Colors.white);
    drawBackground(canvas, size);
    final frameCenter = Offset(size.width / 2.0, size.height / 2.0);
    // c = center of the arc, bottom left of frame
    final c = Offset(frameCenter.dx - W / 2.0, frameCenter.dy + W / 2.0);
    final r = W / 2.0; // arc radius
    final w1 = 4.0 * pi / 180.0; // starting angle
    final w2 = 7.0 * pi / 180.0; // starting angle

    //clip text
    final rect = Rect.fromCenter(center: frameCenter, width: W, height: W);
    canvas.clipRect(rect);

    drawArc(canvas, c, arcStyle1, r - 40);
    drawTextArc(canvas, c, r, w1, "Never again!", style1);
    // drawTextArc(canvas, c, r, w1, "Year Review", style1);

    drawArc(canvas, c, arcStyle2, r - 135); // draw background
    drawTextArc(canvas, c, r - 70.0, w2, "2020", style2);

    var w3 = startAngle; // starting angle
    wordList.forEach((m) {
      drawTextSlant(canvas, c, r + 10.0, w3, m, style3);
      w3 += 10.0 * pi / 180.0;
    });
    drawFrame(canvas, frameCenter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  final W = 600.0;
  void drawFrame(Canvas canvas, Offset center) {
    final rect = Rect.fromCenter(center: center, width: W, height: W);
    final border = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;
    canvas.drawRect(rect, border);
  }

  void drawArc(Canvas canvas, Offset center, Paint border, double radius) {
    final rect =
        Rect.fromCenter(center: center, width: 2 * radius, height: 2 * radius);
    canvas.drawArc(rect, -90 * pi / 180, 90 * pi / 180.0, false, border);
  }

  TextPainter measureText(Canvas canvas, String text, TextStyle style) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: double.maxFinite);
    return textPainter;
  }

  void drawTextArc(Canvas canvas, Offset arcCenter, double radius, double a,
      String text, TextStyle style) {
    final pos = Offset(0, -radius);
    text.split('').forEach((c) {
      final tp = measureText(canvas, c, style);
      final w = tp.width + 5.0;
      final double alpha = asin(w / (2 * radius));
      canvas.save();
      canvas.translate(arcCenter.dx, arcCenter.dy);
      a += alpha;
      canvas.rotate(a);
      a += alpha;
      tp.paint(canvas, pos + Offset(-w / 2.0, 0.0));
      canvas.restore();
    });
  }

  void drawTextSlant(Canvas canvas, Offset arcCenter, double radius, double w,
      String text, TextStyle style) {
    final pos = Offset(radius, 0);
    canvas.save();
    canvas.translate(arcCenter.dx, arcCenter.dy);
    canvas.rotate(w);
    final tp = measureText(canvas, text, style);
    final ww = tp.height;
    tp.paint(canvas, pos + Offset(0, -ww / 2.0));
    canvas.restore();
  }

  void drawBackground(Canvas canvas, Size size) {
    var gradient = RadialGradient(
      center: Alignment(-W / size.width + 0.2, W / size.height - 0.2),
      radius: 1.0,
      colors: [Color(0xff506475), Color(0xff01182b)],
      stops: [0.0, 1.0],
    );
    var rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRect(rect, paint);
  }
}
