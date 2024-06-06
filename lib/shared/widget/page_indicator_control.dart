import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class PageIndicatorControl extends StatefulWidget {
  const PageIndicatorControl({
    required this.pageCount,
    required this.isDesk,
    super.key,
  });

  final bool isDesk;
  final int pageCount;

  @override
  PageIndicatorControlState createState() => PageIndicatorControlState();
}

class PageIndicatorControlState extends State<PageIndicatorControl> {
  int currentPage = 0;

  void nextPage() {
    setState(() {
      currentPage = (currentPage + 1) % widget.pageCount;
    });
  }

  void previousPage() {
    setState(() {
      currentPage = (currentPage - 1 + widget.pageCount) % widget.pageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: KIcon.arrowLeft,
              onPressed: previousPage,
            ),
            Expanded(
              child: SizedBox(
                height: 30,
                child: CustomPaint(
                  painter: ViewpagerIndicatorWidget(
                    pageCount: widget.pageCount,
                    selectedPage: currentPage,
                    pageTitles: [],
                    isDesk: widget.isDesk,
                  ),
                ),
              ),
            ),
            IconButton(
              icon: KIcon.arrowRight,
              onPressed: nextPage,
            ),
          ],
        ),
      ],
    );
  }
}
