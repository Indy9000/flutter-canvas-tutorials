import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Center(
        child: SizedBox(
            width: 300,
            child: Container(
              // color: Colors.red,
              child: Stack(
                children: [
                  _buildListView(),
                  AnimWidget(),
                ],
              ),
            )),
      ),
    );
  }
}

Widget _buildListView() {
  final List<String> entries = <String>['A', 'B', 'C', 'A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100, 600, 500, 100];

  return ListView.separated(
    padding: const EdgeInsets.all(8),
    itemCount: entries.length,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        height: 50,
        color: Colors.amber[colorCodes[index]],
        child: Center(child: Text('Entry ${entries[index]}')),
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(),
  );
}

class AnimWidget extends StatefulWidget {
  @override
  _AnimWidgetState createState() => _AnimWidgetState();
}

const count = 100;
final rng = Random();
final palettes = [
  [0xFF69D2E7, 0xFFA7DBD8, 0xFFE0E4CC, 0xFFF38630, 0xFFFA6900],
  [0xFFFE4365, 0xFFFC9D9A, 0xFFF9CDAD, 0xFFC8C8A9, 0xFF83AF9B],
  [0xFFECD078, 0xFFD95B43, 0xFFC02942, 0xFF542437, 0xFF53777A],
  [0xFF556270, 0xFF4ECDC4, 0xFFC7F464, 0xFFFF6B6B, 0xFFC44D58],
  [0xFF774F38, 0xFFE08E79, 0xFFF1D4AF, 0xFFECE5CE, 0xFFC5E0DC],
  [0xFFE8DDCB, 0xFFCDB380, 0xFF036564, 0xFF033649, 0xFF031634],
  [0xFF490A3D, 0xFFBD1550, 0xFFE97F02, 0xFFF8CA00, 0xFF8A9B0F],
  [0xFF594F4F, 0xFF547980, 0xFF45ADA8, 0xFF9DE0AD, 0xFFE5FCC2],
  [0xFF00A0B0, 0xFF6A4A3C, 0xFFCC333F, 0xFFEB6841, 0xFFEDC951],
];

class _AnimWidgetState extends State<AnimWidget> {
  late Timer timer;
  final particles = List<Particle>.generate(count, (index) => Particle());

  @override
  initState() {
    super.initState();
    print("${particles.length}");
    this.timer = Timer.periodic(Duration(milliseconds: 1000 ~/ 60), (timer) {
      setState(() {
        particles.forEach((p) {
          p.pos += Offset(p.dx, p.dy);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: true,
      child: Container(
          // color: Color(0x1100ff00),
          child: CustomPaint(
        child: Container(),
        painter: MyAnim(particles),
      )),
    );
  }
}

class MyAnim extends CustomPainter {
  List<Particle> particles;
  MyAnim(this.particles);

  @override
  void paint(Canvas canvas, Size size) {
    this.particles.forEach((p) {
      canvas.drawCircle(
          p.pos,
          p.radius,
          Paint()
            ..style = PaintingStyle.fill
            ..color = p.color);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class Particle {
  Particle() {
    this.radius = Utils.Range(3, 10);
    this.color = Color(palettes[rng.nextInt(palettes.length)][rng.nextInt(5)]);
    final x = Utils.Range(0, 300);
    final y = Utils.Range(0, 900);
    this.pos = Offset(x, y);
    this.dx = Utils.Range(-0.1, 0.1);
    this.dy = Utils.Range(-0.1, 0.1);
  }
  double dx = 0.1;
  double dy = 0.1;
  double radius = 10;
  Color color = Colors.red;
  Offset pos = Offset(0, 0);
}

class Utils {
  static double Range(double min, double max) =>
      rng.nextDouble() * (max - min) + min;
}
