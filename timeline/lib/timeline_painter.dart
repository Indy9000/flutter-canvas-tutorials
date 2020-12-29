import 'dart:math';

import 'package:flutter/material.dart';
import 'package:timeline/data.dart';
import 'dart:ui' as ui;

class TimelinePainter extends CustomPainter {
  final DateTime startDate;
  final DateTime endDate;
  final DataCard dataCard;
  final ui.Image img;
  TimelinePainter(this.startDate, this.endDate, this.dataCard, this.img);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  final H = 100.0;
  final border = Paint()
    ..color = Colors.white
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  final monthNames = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  final newYearBg1 = Paint()
    ..color = Color(0xff2e2255)
    ..style = PaintingStyle.fill;
  final newYearBg2 = Paint()
    ..color = Color(0xff1d1638)
    ..style = PaintingStyle.fill;

  final title1Style = TextStyle(color: Colors.white54, fontSize: 30);
  final title2Style = TextStyle(color: Colors.white38, fontSize: 20);
  final monthStyle =
      TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold);
  final yearBGTextStyle = TextStyle(
      color: Colors.white10, fontSize: 400, fontWeight: FontWeight.bold);

  @override
  void paint(Canvas canvas, Size size) {
    final blockW = size.width / 12.0; // we display 12 months
    final daysInMonth = DateTime(startDate.year, startDate.month + 1, 0).day;
    final fraction = startDate.day.toDouble() / daysInMonth.toDouble();
    var xStart = -fraction * blockW;

    drawBackgroundShading(canvas, blockW, size, xStart);
    drawImage(canvas, size);
    drawYearOnBackground(canvas, blockW, size.height / 2, xStart);
    drawMonths(canvas, size, blockW, xStart);
    drawCard(canvas, size, 200.0);
  }

  void drawMonths(Canvas canvas, Size size, double blockW, double xStart) {
    var pos = Offset(0, size.height);
    var year = startDate.year;
    var month = startDate.month;
    var day = startDate.day;

    final padding = Offset(5, -10);
    var d = DateTime.utc(startDate.year, startDate.month, 1);
    var m = 0;
    // draw months
    while (d.isBefore(endDate)) {
      // draw month name
      drawTextVertical(canvas, pos + padding + Offset(xStart, 0),
          monthNames[month - 1], monthStyle);

      // draw vertical line
      final p1 = Offset(m * blockW + xStart, size.height);
      final p2 = Offset(m * blockW + xStart, size.height - H);
      canvas.drawLine(p1, p2, border);
      m++;

      // advance to the next month
      if (month == 12) {
        year++;
        month = 1;
      } else {
        month++;
      }

      pos += Offset(blockW, 0);
      d = DateTime.utc(year, month, 1);
    }
  }

  void drawYearOnBackground(
      Canvas canvas, double blockW, double hh, double xStart) {
    var yr = startDate.year;
    var mnth = startDate.month;
    final mm1 = (1 - mnth) * blockW + xStart;
    final mm2 = (1 - mnth + 12) * blockW + xStart;
    // final hh = size.height / 2.0;
    drawText(canvas, Offset(mm1, hh), yr.toString(), yearBGTextStyle);
    drawText(canvas, Offset(mm2, hh), (yr + 1).toString(), yearBGTextStyle);
  }

  void drawBackgroundShading(
      Canvas canvas, double blockW, Size size, double xStart) {
    var yr = startDate.year;
    var mnth = startDate.month;
    final mm1 = (1 - mnth) * blockW + xStart;
    final mm2 = (1 - mnth + 12) * blockW + xStart;

    var rect = Rect.fromLTRB(mm1, 0, mm2, size.height);
    var bg = (yr % 2 == 0) ? newYearBg1 : newYearBg2;
    canvas.drawRect(rect, bg);

    rect = Rect.fromLTRB(mm2, 0, size.width, size.height);
    bg = ((yr + 1) % 2 == 0) ? newYearBg1 : newYearBg2;
    canvas.drawRect(rect, bg);
  }

  TextPainter measureText(String s, TextStyle style) {
    final ts = TextSpan(text: s, style: style);
    final tp = TextPainter(
        text: ts, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    tp.layout(minWidth: 0, maxWidth: double.maxFinite);
    return tp;
  }

  void paintText(Canvas canvas, Offset pos, TextPainter tp) {
    tp.paint(canvas, pos);
  }

  void drawText(Canvas canvas, Offset pos, String s, TextStyle style) {
    final tp = measureText(s, style);
    paintText(canvas, pos, tp);
  }

  // pos bottom,left of the rect to draw the vertical text
  void drawTextVertical(Canvas canvas, Offset pos, String s, TextStyle style) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(-90 * pi / 180);
    drawText(canvas, Offset(0, 0), s, style);
    canvas.restore();
  }

  final pathPaint = Paint()
    ..color = Color(0xffcf4d5f)
    ..strokeWidth = 3.0
    ..strokeJoin = StrokeJoin.round
    ..style = PaintingStyle.stroke;

  final rectPaint = Paint()..style = PaintingStyle.fill;

  void drawCard(Canvas canvas, Size size, double yOffset) {
    final xPerDay = size.width / 365; // assume 365 days in year
    final pad = 10.0;
    var height = 100.0; // height of a series plot

    // draw charts
    dataCard.serii.forEach((series) {
      if (series.plotType == PlotType.Line) {
        drawLinePlot(canvas, yOffset, xPerDay, height, series);
      }
      if (series.plotType == PlotType.TimePeriod) {
        final h = drawTimePeriod(canvas, yOffset, xPerDay, height, series);
        height += (h + pad);
      }
    });

    // draw outer border
    final aa = dataCard.startDate.difference(startDate);
    final xStart = aa.inDays * xPerDay;
    final bb = dataCard.endDate.difference(startDate);
    final xFinish = bb.inDays * xPerDay;
    final rect = Rect.fromLTWH(xStart - pad, yOffset - pad,
        xFinish - xStart + 2 * pad, height + 2 * pad);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(10.0));
    canvas.drawRRect(rrect, border);
    // draw Title
    final ofs = Offset(5, 5);
    drawText(canvas, rect.topLeft + ofs, dataCard.name, title1Style);
    // drawText(canvas, rect.topCenter + ofs, dataCard.serii[0].name, title1Style);
  }

  void drawLinePlot(Canvas canvas, double yOffset, double xPerDay,
      double height, DataSeries series) {
    final yRange = series.maxValue - series.minValue;
    final yFactor = height / yRange;
    var path = Path();
    bool pathStarted = false;
    series.items.forEach((di) {
      final aa = di.timestamp.difference(startDate);
      final x = aa.inDays * xPerDay;
      final y = (di.value - series.minValue) * yFactor;
      if (!pathStarted) {
        path.moveTo(x, yOffset + height - y);
        pathStarted = true;
      }
      canvas.drawCircle(Offset(x, yOffset + height - y), 3.0, pathPaint);
      path.lineTo(x, yOffset + height - y);
    });
    canvas.drawPath(path, pathPaint);
  }

  double drawTimePeriod(Canvas canvas, double yOffset, double xPerDay,
      double height, DataSeries series) {
    final x1 = series.items[0].timestamp.difference(startDate).inDays * xPerDay;
    final x2 = series.items[1].timestamp.difference(startDate).inDays * xPerDay;
    final y1 = 30.0;
    final y2 = 0.0;
    final rect =
        Rect.fromLTRB(x1, yOffset + height - y1, x2, yOffset + height + y2);

    rectPaint.shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        stops: [0.5, 1.0],
        colors: [Color(0xff662397), Color(0xffdc6c62)]).createShader(rect);
    canvas.drawRect(rect, rectPaint);
    final tp = measureText(series.name, title2Style);
    final pos = Offset(rect.left + rect.width / 2.0 - tp.width / 2.0,
        rect.bottom - rect.height / 2.0 - tp.height / 2.0);
    paintText(canvas, pos, tp);
    return y1;
  }

  void drawImage(Canvas canvas, Size size) {
    if (img == null) return;
    final xPerDay = size.width / 365; // assume 365 days in year
    final x = DateTime(2021, 1, 1).difference(startDate).inDays * xPerDay;
    final y = size.height - 300;
    final W = 400.0;
    final H = 300.0;
    if (img != null) {
      var rect = Rect.fromLTWH(x, y, W, H);
      paintImage(img, rect, canvas, Paint(), BoxFit.cover);
    }
  }

  void paintImage(
      ui.Image image, Rect outputRect, Canvas canvas, Paint paint, BoxFit fit) {
    final Size imageSize =
        Size(image.width.toDouble(), image.height.toDouble());
    final FittedSizes sizes = applyBoxFit(fit, imageSize, outputRect.size);
    final Rect inputSubrect =
        Alignment.center.inscribe(sizes.source, Offset.zero & imageSize);
    final Rect outputSubrect =
        Alignment.center.inscribe(sizes.destination, outputRect);
    canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
  }
}
