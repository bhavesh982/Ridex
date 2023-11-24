import 'package:flutter/material.dart';
class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xff103232);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();
    path.moveTo(0, size.height * 0.35);
    path.quadraticBezierTo(
        size.width /2, -200, size.width, size.height * 0.35);
    path.lineTo(size.width+5,-5);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}