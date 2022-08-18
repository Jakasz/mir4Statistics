import 'package:flutter/material.dart';

class TabCircleDecorator extends Decoration {
  final Color color;
  final double radius;

  TabCircleDecorator({required this.color, required this.radius});


  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CircleTabBoxPainter(color: color, radius:radius);
  }

}


class CircleTabBoxPainter extends BoxPainter{
  final double radius;
  final Color color;

  CircleTabBoxPainter({required this.radius, required this.color});


  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
   final Offset circle = offset + Offset(configuration.size!.width/2-radius/2, configuration.size!.height-radius/2);
    canvas.drawCircle(circle, radius, _paint);
  }

}