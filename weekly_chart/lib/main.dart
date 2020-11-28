import 'dart:math';

import 'package:flutter/material.dart';

import 'weekly_chart.dart';

var rng = Random();
void main() {
  // generate the dummy data
  var data = List<double>();
  for (var i = 0; i < 20; i++) {
    data.add(rng.nextDouble() * 100.0);
  }

  runApp(MyApp(data));
}

class MyApp extends StatelessWidget {
  final List<double> data;
  MyApp(this.data);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Week Chart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeeklyChart(data),
    );
  }
}
