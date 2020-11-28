import 'package:flutter/material.dart';

class MyCanvas extends CustomPainter {
  final List<double> weekData;
  final double percentage;
  final double minD;
  final double maxD;
  final rangeD;
  MyCanvas(this.weekData, this.minD, this.maxD, this.rangeD, this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    var offset = Offset(size.width / 2, size.height / 2);
    drawFrame(canvas, offset);
    drawChart(canvas, offset);
  }

  var W = 600.0;
  void drawFrame(Canvas canvas, Offset offset) {
    var rect = Rect.fromCenter(center: offset, width: W, height: W);

    var bg = Paint()..color = Color(0xfff2f3f0);
    canvas.drawRect(rect, bg);

    var border = Paint()
      // ..color = Color(0xff980e3c)
      ..color = Colors.black45
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;
    canvas.drawRect(rect, border);
  }

  var chartH = 150.0;
  var chartW = 500.0;
  var xLabels = ["M", "T", "W", "T", "F", "S", "S"];
  final regularStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 15.0,
  );
  final titleStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w900,
    fontSize: 40.0,
    // backgroundColor: Color(0xfff1dfcd),
  );

  void drawChart(Canvas canvas, Offset center) {
    // chart border
    var rect = Rect.fromCenter(center: center, width: chartW, height: chartH);

    var colW = chartW / 6.0; // distance between x points

    var startX = rect.left;
    var startY = rect.bottom;

    var x = startX;
    var p = Path();
    p.moveTo(startX, startY); // move to first point
    // draw line to each data point
    bool first = true;
    this.weekData.forEach((d) {
      var r = chartH / rangeD;
      var y = (d - minD) * r * percentage;
      if (first) {
        p.moveTo(x, startY - y);
        first = false;
      }
      p.lineTo(x, startY - y);
      x += colW;
    });

    // close the path
    p.moveTo(x - colW, startY);
    p.moveTo(startX, startY);

    // chart border paint
    var chBorder = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // draw chart guides and labels
    x = startX;
    var w = 0;
    for (var i = 0; i < 7; i++) {
      var p1 = Offset(x, startY);
      var p2 = Offset(x, startY - chartH);
      // draw vert guide
      canvas.drawLine(p1, p2, chBorder);
      // draw xlabel
      drawText(canvas, Size(10, 10), Offset(x, startY + 10), regularStyle,
          xLabels[w++]);
      x += colW;
    }

    var yd = chartH / 3.0;
    canvas.drawLine(Offset(startX, startY - yd),
        Offset(startX + chartW, startY - yd), chBorder);
    canvas.drawLine(Offset(startX, startY - 2 * yd),
        Offset(startX + chartW, startY - 2 * yd), chBorder);

    // draw chart bg fill
    // var chFill = Paint()
    //   ..color = Color(0xffd5d2d7)
    //   ..style = PaintingStyle.fill;
    // canvas.drawRect(rect, chFill);

    // draw path
    var g = Paint()
      // ..color = Color(0xff980e3c)
      ..color = Color(0xff1dcc92)
      ..strokeWidth = 5.0
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(p, g);

    // draw chart border
    canvas.drawRect(rect, chBorder);

    // draw y axis
    drawText(canvas, Size(40, 10), Offset(startX - 40, startY), regularStyle,
        minD.toStringAsFixed(1));
    drawText(canvas, Size(40, 10), Offset(startX - 40, startY - chartH),
        regularStyle, maxD.toStringAsFixed(1));

    // draw title
    drawText(canvas, Size(chartW, 20), Offset(startX, startY - chartH - 50),
        titleStyle, "Weekly Data");
  }

  drawText(
      Canvas canvas, Size size, Offset offset, TextStyle style, String text) {
    final textSpan = TextSpan(
      text: text,
      style: style,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.right,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: size.width,
    );
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
