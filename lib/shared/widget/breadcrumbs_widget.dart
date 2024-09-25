import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

// class PageIndicatorControl extends StatelessWidget {
//   const PageIndicatorControl({
//     required this.pageName,
//     required this.selectedPage,
//     super.key,
//   });

//   final List<String> pageName;
//   final int selectedPage;
//   @override
//   Widget build(BuildContext context) {
//     return
//         // Column(
//         //   mainAxisAlignment: MainAxisAlignment.center,
//         //   children: [
//         //     Row(
//         //       mainAxisAlignment: MainAxisAlignment.center,
//         //       children: [
//         //         IconButton(
//         //           icon: KIcon.arrowLeft,
//         //           onPressed: () => setState(
//         //             () => currentPage =
//         //                 (currentPage - 1 + widget.pageCount) % widget
//         // .pageCount,
//         //           ),
//         //         ),
//         //         Expanded(
//         //           child:
//         CustomPaint(
//       painter: ViewpagerIndicatorWidget(
//         pageCount: pageName.length,
//         selectedPage: selectedPage,
//       ),
//     )
//         // ),
//         //         IconButton(
//         //           icon: KIcon.arrowRight,
//         //           onPressed: () => setState(
//         //             () => currentPage = (currentPage + 1) % widget.pageCount,
//         //           ),
//         //         ),
//         //       ],
//         //     ),
//         //   ],
//         // )
//         ;
//   }
// }

class BreadcrumbsWidget extends StatelessWidget {
  const BreadcrumbsWidget({
    required this.pageName,
    required this.selectedPage,
    this.unselectedCircleRadius = KSize.kPixel15,
    this.selectedCircleRadius = KSize.kPixel11,
    this.selectedLineHeight = KSize.kPixel2,
    this.unselectedLineHeight = KSize.kPixel6,
    this.selectedColor = AppColors.materialThemeKeyColorsPrimary,
    this.unselectedColor = AppColors.materialThemeKeyColorsNeutral,
    super.key,
    this.circularSymetricPadding = KSize.kPixel3,
  });

  final List<String> pageName;
  final int selectedPage;
  final double unselectedCircleRadius;
  final double selectedCircleRadius;
  final double selectedLineHeight;
  final double unselectedLineHeight;
  final Color selectedColor;
  final Color unselectedColor;
  final double circularSymetricPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            pageName.length,
            (index) => Text(
              pageName.elementAt(index),
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
        ),
        CustomPaint(
          size: const Size(double.infinity, KSize.kPixel30),
          painter: ViewpagerIndicatorWidget(
            pageName: pageName,
            selectedPage: selectedPage - 1,
            unselectedCircleRadius: unselectedCircleRadius,
            selectedCircleRadius: selectedCircleRadius,
            selectedLineHeight: selectedLineHeight,
            unselectedLineHeight: unselectedLineHeight,
            selectedColor: selectedColor,
            unselectedColor: unselectedColor,
          ),
        ),
      ],
    );
  }
}

class ViewpagerIndicatorWidget extends CustomPainter {
  ViewpagerIndicatorWidget({
    required this.pageName,
    required this.selectedCircleRadius,
    required this.unselectedCircleRadius,
    required this.selectedLineHeight,
    required this.unselectedLineHeight,
    required this.selectedColor,
    required this.unselectedColor,
    required this.selectedPage,
  });

  final List<String> pageName;
  final double selectedCircleRadius;
  final double unselectedCircleRadius;
  final double selectedLineHeight;
  final double unselectedLineHeight;
  final Color selectedColor;
  final Color unselectedColor;
  final int selectedPage;

  @override
  void paint(Canvas canvas, Size size) {
    final textWidths = pageName.map((text) {
      final textPainter = TextPainter(
        text:
            TextSpan(text: text, style: AppTextStyle.materialThemeTitleMedium),
        textDirection: TextDirection.ltr,
        maxLines: 1,
        // overflow: TextOverflow.ellipsis,
      )..layout();
      return textPainter.width;
    }).toList();
    final pageCount = pageName.length;
    final paint = Paint()
      ..color = unselectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = unselectedLineHeight
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(
        (textWidths.elementAt(0) / 2) - unselectedCircleRadius - KSize.kPixel2,
        size.height / 2,
      ),
      Offset(
        (size.width - (textWidths.elementAt(pageCount - 1) / 2)) +
            unselectedCircleRadius +
            KSize.kPixel2,
        size.height / 2,
      ),
      paint,
    );

    final textLenght = textWidths.sum;

    final positions = <double>[
      textWidths.elementAt(0) / 2,
      if (pageCount > 2)
        ...List.generate(
          pageCount - 2,
          (index) =>
              (((index + 1) * (size.width - textLenght)) / (pageCount - 1)) +
              textWidths.sublist(0, index + 1).sum +
              (textWidths.elementAt(index + 1) / 2),
        ),
      size.width - textWidths.elementAt(pageCount - 1) / 2,
    ];
    for (var i = 0; i < pageCount; i++) {
      final circleY = size.height / 2;
      final circleX = positions[i];

      paint
        ..color = unselectedColor
        ..style = PaintingStyle.fill;
      canvas.drawCircle(
        Offset(circleX, circleY),
        unselectedCircleRadius,
        paint,
      );

      if (i <= selectedPage) {
        paint.color = selectedColor;
        canvas.drawCircle(
          Offset(circleX, circleY),
          selectedCircleRadius,
          paint,
        );
      }
    }

    double lineEndX;
    if (selectedPage == pageCount - 1) {
      lineEndX = size.width;
    } else {
      lineEndX = positions[selectedPage] + selectedCircleRadius;
    }

    paint
      ..color = selectedColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = selectedLineHeight;

    canvas.drawLine(
      Offset(
        (textWidths.elementAt(0) / 2) - unselectedCircleRadius - KSize.kPixel2,
        size.height / 2,
      ),
      Offset(
        (lineEndX - (textWidths.elementAt(pageCount - 1) / 2)) +
            unselectedCircleRadius +
            KSize.kPixel2,
        size.height / 2,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is ViewpagerIndicatorWidget &&
        selectedPage != oldDelegate.selectedPage;
  }
}
