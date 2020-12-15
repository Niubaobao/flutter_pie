import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaperPainter extends CustomPainter {
  final List<double> sourceList;
  final List destList;
  double totalSource;
  double totalAngle = pi * 2;
  List<Paint> paintlist = [];
  double _prevAngle = 0;

  List<Color> colorList = [
    Colors.red,
    Colors.orange,
    Colors.blue,
    Colors.yellow
  ];

  PaperPainter({this.sourceList, this.destList}) {
    totalSource = sourceList.reduce((a, b) => a + b);

    for (int i = 0; i < sourceList.length; i++) {
      var paint = (Paint()..color = colorList[i]);
      paintlist.add(paint);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    // 创建画笔 画对应的圆
    for (int i = 0; i < sourceList.length; i++) {
      var rect = Rect.fromLTWH(0, 0, 200, 200);
      double sweepAngle = (sourceList[i] / totalSource) * pi * 2;
      canvas.drawArc(rect, _prevAngle, sweepAngle, true, paintlist[i]);
      double x = cos(_prevAngle + sweepAngle / 2) * 60;
      double y = sin(_prevAngle + sweepAngle / 2) * 60;
      _prevAngle += sweepAngle;

      // 将文字画到屏幕中间
      drawCenterText(canvas, size, x, y, destList[i], paintlist[i]);
    }
  }

  drawCenterText(
      Canvas canvas, Size size, double x, double y, desc, Paint paint) {
    var textPainter = TextPainter(
        text: TextSpan(
            text: desc, style: TextStyle(fontSize: 12, color: Colors.black)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取

    Rect rect = Rect.fromCenter(
      center: Offset(100 + x, 100 + y),
      width: size.width + 6,
      height: size.height + 6,
    );

    RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(4));

    canvas.drawRRect(rrect, paint..color = Colors.white);

    textPainter.paint(
        canvas,
        Offset(
            (100 - size.width / 2) + x, (100 - size.height / 2) + y)); // 进行绘制
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
