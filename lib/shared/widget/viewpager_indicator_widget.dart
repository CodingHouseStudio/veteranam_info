import 'package:flutter/material.dart';

class ViewpagerIndicatorWidget extends CustomPainter {
  ViewpagerIndicatorWidget({
    required this.pageCount,
    this.selectedCircleRadius = 13.0,
    this.unselectedCircleRadius = 10.0,
    this.lineWidth = 3.0,
    this.lineHeight = 7.0,
    this.selectedColor = Colors.green,
    this.unselectedColor = Colors.grey,
    this.selectedPage = 0,
  });

  final int pageCount;
  final double selectedCircleRadius;
  final double unselectedCircleRadius;
  final double lineWidth;
  final double lineHeight;
  final Color selectedColor;
  final Color unselectedColor;
  int selectedPage;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = unselectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineHeight;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    const edgeMargin = 20.0;

    final positions = <double>[
      edgeMargin,
      size.width / 2,
      size.width - edgeMargin,
    ];

    for (var i = 0; i < pageCount; i++) {
      final circleY = size.height / 2;
      final circleX = positions[i];

      paint
        ..color = unselectedColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(circleX, circleY),
        selectedCircleRadius,
        paint,
      );

      if (i <= selectedPage) {
        paint.color = selectedColor;
        canvas.drawCircle(
          Offset(circleX, circleY),
          unselectedCircleRadius,
          paint,
        );
      }
    }

    double lineEndX;
    if (selectedPage == pageCount - 1) {
      // coverage:ignore-start
      lineEndX = size.width;
      // coverage:ignore-end
    } else {
      lineEndX = positions[selectedPage] + unselectedCircleRadius;
    }

    paint
      ..color = selectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = lineWidth;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(lineEndX, size.height / 2),
      paint,
    );
  }

  // coverage:ignore-start
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ViewpagerIndicatorWidget &&
        selectedPage != oldDelegate.selectedPage;
  }
  // coverage:ignore-end
}
