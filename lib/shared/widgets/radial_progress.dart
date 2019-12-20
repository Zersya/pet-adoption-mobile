
import 'dart:math';

import 'package:flutter/material.dart';

class RadialProgress extends StatelessWidget {
  final double radius, strokeWidth;
  final int percent;
  final Color lineColor, progressColor;
  final Widget child;

  const RadialProgress({
    Key key,
    @required this.radius,
    @required this.child,
    @required this.strokeWidth,
    @required this.percent,
    @required this.lineColor,
    @required this.progressColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      child: CustomPaint(
        painter: RadialProgresPainter(
            this.lineColor, this.progressColor, this.strokeWidth, this.percent),
        child: Center(child: child),
      ),
    );
  }
}

class RadialProgresPainter extends CustomPainter {
  final Color lineColor;
  final Color progressColor;
  final double strokeWidth;
  final int percent;

  RadialProgresPainter(
    this.lineColor,
    this.progressColor,
    this.strokeWidth,
    this.percent,
  );

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);

    Paint complete = new Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    double arcAngle = 2 * pi * (percent / 100);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
