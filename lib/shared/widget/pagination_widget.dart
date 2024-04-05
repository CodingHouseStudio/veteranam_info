import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class PaginationWidget extends StatefulWidget {
  const PaginationWidget({
    required this.items,
    required this.itemBuilder,
    this.pageSize = 10,
    this.currentPage = 1,
    super.key,
  });

  final List<int> items;
  final Widget Function(BuildContext context, List<int> items) itemBuilder;
  final int pageSize;
  final int currentPage;

  @override
  PaginationWidgetState createState() => PaginationWidgetState();
}

class PaginationWidgetState extends State<PaginationWidget> {
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _currentPage = widget.currentPage;
  }

  void _previousPage() {
    setState(() {
      _currentPage = _currentPage > 1 ? _currentPage - 1 : 1;
    });
  }

  void _nextPage() {
    setState(() {
      final maxPage = (widget.items.length / widget.pageSize).ceil();
      _currentPage = _currentPage < maxPage ? _currentPage + 1 : maxPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (widget.items.length / widget.pageSize).ceil();
    final isFirstPage = _currentPage == 1;
    final isLastPage = _currentPage == totalPages;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              label: const Text(KAppText.previousPage),
              onPressed: isFirstPage ? null : _previousPage,
              style: KButtonStyles.transparentButtonStyle,
              icon: KIcon.arrowLeft,
            ),
            _buildPageNumbers(context, totalPages),
            ElevatedButton.icon(
              label: const Text(KAppText.nextPage),
              onPressed: isLastPage ? null : _nextPage,
              style: KButtonStyles.transparentButtonStyle,
              icon: KIcon.arrowRight,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPageNumbers(BuildContext context, int totalPages) {
    final pageWidgets = <Widget>[];

    var start = _currentPage - 2;
    var end = _currentPage + 1;

    if (start < 1) {
      start = 1;
      end = min(totalPages, start + 4);
    }
    if (end > totalPages) {
      end = totalPages;
      start = max(1, end - 4);
    }
    for (var i = start; i < _currentPage - 1 && i <= start + 2; i++) {
      pageWidgets.add(_buildPageButton(i));
    }
    if (start > 2) {
      pageWidgets.add(const Text(KAppText.text));
    }
    pageWidgets.add(_buildPageButton(_currentPage));
    if (end < totalPages - 1) {
      pageWidgets.add(const Text(KAppText.text));
    }
    for (var i = _currentPage + 2; i <= end && i >= end - 2; i++) {
      pageWidgets.add(_buildPageButton(i));
    }
    return Row(
      children: pageWidgets,
    );
  }

  Widget _buildPageButton(int pageNumber) {
    return GestureDetector(
      onTap: () => setState(() => _currentPage = pageNumber),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize8),
        child: _currentPage == pageNumber
            ? Container(
                padding: const EdgeInsets.all(KSize.kPixel10),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.widgetBackground,
                ),
                child: Text(
                  '$pageNumber',
                  style: AppTextStyle.text24,
                ),
              )
            : Text(
                '$pageNumber ',
                style: AppTextStyle.text24,
              ),
      ),
    );
  }
}
