import 'package:flutter/material.dart';

class MyCanvas extends CustomPainter {
  final List<double> weekData;
  final double minD;
  final double maxD;
  final double rangeD;
  final double percentage;
  MyCanvas(this.weekData, this.minD, this.maxD, this.rangeD, this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.white;
    canvas.drawPaint(paint);
    var center = Offset(size.width / 2, size.height / 2);
    drawFrame(canvas, center);
    drawChart(canvas, center);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  var W = 600.0;
  void drawFrame(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: W, height: W);
    // fill rect
    var bg = Paint()..color = Color(0xfff2f3f0);
    canvas.drawRect(rect, bg);
    // draw border
    var border = Paint()
      ..color = Colors.black45
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;
    canvas.drawRect(rect, border);
  }

  var chartW = 500.0;
  var chartH = 150.0;
  void drawChart(Canvas canvas, Offset center) {
    var rect = Rect.fromCenter(center: center, width: chartW, height: chartH);
    var chBorder = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    var dpPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;

    var titleStyle = TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.w900,
    );
    var labelStyle = TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
    );
    // draw chart borders
    drawChartBorder(canvas, chBorder, rect);
    // draw data points
    drawDataPoints(canvas, dpPaint, rect);
    // draw chart guides
    drawChartGuides(canvas, chBorder, rect);
    // draw chart title
    drawText(canvas, rect.topLeft + Offset(0, -60), rect.width, titleStyle,
        "Weekly Data");
    drawLabels(canvas, rect, labelStyle);
  }

  void drawChartBorder(Canvas canvas, Paint chBorder, Rect rect) {
    canvas.drawRect(rect, chBorder);
  }

  void drawChartGuides(Canvas canvas, Paint chBorder, Rect rect) {
    var x = rect.left;
    var colW = chartW / 6.0;
    for (var i = 0; i < 7; i++) {
      var p1 = Offset(x, rect.bottom);
      var p2 = Offset(x, rect.top);
      canvas.drawLine(p1, p2, chBorder);
      x += colW;
    }

    // draw horizontal lines
    var yD = chartH / 3.0;
    canvas.drawLine(Offset(rect.left, rect.bottom - yD),
        Offset(rect.right, rect.bottom - yD), chBorder);
    canvas.drawLine(Offset(rect.left, rect.bottom - yD * 2),
        Offset(rect.right, rect.bottom - yD * 2), chBorder);
  }

  void drawDataPoints(Canvas canvas, dpPaint, Rect rect) {
    if (weekData == null) return;
    // this ratio is the number of y pixels per unit data
    var yRatio = chartH / rangeD;
    var colW = chartW / 6.0;
    var p = Path();
    var x = rect.left;
    bool first = true;
    weekData.forEach((d) {
      // (d-minD) because we start our range at min value
      var y = (d - minD) * yRatio * percentage;
      if (first) {
        p.moveTo(x, rect.bottom - y);
        first = false;
      } else {
        p.lineTo(x, rect.bottom - y);
      }
      x += colW;
    });

    p.moveTo(x - colW, rect.bottom);
    p.moveTo(rect.left, rect.bottom);
    canvas.drawPath(p, dpPaint);
  }

  drawText(Canvas canvas, Offset position, double width, TextStyle style,
      String text) {
    final textSpan = TextSpan(text: text, style: style);
    final textPainter =
        TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout(minWidth: 0, maxWidth: width);
    textPainter.paint(canvas, position);
  }

  void drawLabels(Canvas canvas, Rect rect, TextStyle labelStyle) {
    final xLabel = ["M", "T", "W", "T", "F", "S", "S"];
    var colW = chartW / 6.0;
    // draw x Label
    var x = rect.left;
    for (var i = 0; i < 7; i++) {
      drawText(canvas, Offset(x, rect.bottom + 15), 20, labelStyle, xLabel[i]);
      x += colW;
    }

    //draw y Label
    drawText(canvas, rect.bottomLeft + Offset(-35, -10), 40, labelStyle,
        minD.toStringAsFixed(1)); // print min value
    drawText(canvas, rect.topLeft + Offset(-35, 0), 40, labelStyle,
        maxD.toStringAsFixed(1)); // print max value
  }
}
