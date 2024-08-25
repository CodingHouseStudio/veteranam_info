import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class PageIndicatorControl extends StatefulWidget {
  const PageIndicatorControl({required this.pageCount, super.key});

  final int pageCount;

  @override
  PageIndicatorControlState createState() => PageIndicatorControlState();
}

class PageIndicatorControlState extends State<PageIndicatorControl> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         IconButton(
        //           icon: KIcon.arrowLeft,
        //           onPressed: () => setState(
        //             () => currentPage =
        //                 (currentPage - 1 + widget.pageCount) % widget
        // .pageCount,
        //           ),
        //         ),
        //         Expanded(
        //           child:
        SizedBox(
      height: 30,
      child: CustomPaint(
        painter: ViewpagerIndicatorWidget(
          pageCount: widget.pageCount,
          selectedPage: currentPage,
        ),
      ),
    )
        // ),
        //         IconButton(
        //           icon: KIcon.arrowRight,
        //           onPressed: () => setState(
        //             () => currentPage = (currentPage + 1) % widget.pageCount,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ],
        // )
        ;
  }
}
