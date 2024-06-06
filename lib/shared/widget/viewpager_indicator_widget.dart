import 'package:flutter/material.dart';

class ViewpagerIndicatorWidget extends CustomPainter {
  ViewpagerIndicatorWidget({
    required this.pageCount,
    required this.pageTitles,
    required this.isDesk,
    this.selectedCircleRadius = 13.0,
    this.unselectedCircleRadius = 10.0,
    this.lineWidth = 3.0,
    this.lineHeight = 7.0,
    this.selectedColor = Colors.white,
    this.unselectedColor = Colors.grey,
    this.selectedPage = 0,
  });

  final bool isDesk;
  final int pageCount;
  final List<String> pageTitles;
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
    final step = (size.width - 2 * edgeMargin) / (pageCount - 1);

    final textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    for (var i = 0; i < pageCount; i++) {
      final circleX = edgeMargin + i * step;
      final circleY = size.height / 2;

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

      final textSpan = TextSpan(
        text: pageTitles[i],
        style: isDesk
            ? const TextStyle(fontSize: 24)
            : const TextStyle(fontSize: 16),
      );
      textPainter
        ..text = textSpan
        ..layout()
        ..paint(
          canvas,
          Offset(
            circleX - textPainter.width / 2,
            circleY - selectedCircleRadius - textPainter.height - 5,
          ),
        );
    }

    double lineEndX;
    if (selectedPage == pageCount - 1) {
      lineEndX = size.width;
    } else {
      lineEndX = edgeMargin + selectedPage * step + unselectedCircleRadius;
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ViewpagerIndicatorWidget &&
        (selectedPage != oldDelegate.selectedPage ||
            pageTitles != oldDelegate.pageTitles);
  }
}
