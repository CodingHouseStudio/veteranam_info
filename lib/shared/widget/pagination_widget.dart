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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                key: KWidgetkeys.widget.pagination.buttonPrevious,
                label: const Text(KAppText.previousPage),
                onPressed: isFirstPage ? null : _previousPage,
                style: KButtonStyles.transparentButtonStyle,
                icon: KIcon.arrowLeft,
              ),
              _buildPageNumbers(context, totalPages),
              ElevatedButton(
                key: KWidgetkeys.widget.pagination.buttonNext,
                onPressed: isLastPage ? null : _nextPage,
                style: KButtonStyles.transparentButtonStyle,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(KAppText.nextPage),
                    KIcon.arrowRight,
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageNumbers(BuildContext context, int totalPages) {
    final pageWidgets = <Widget>[];

    var start = _currentPage;
    var end = _currentPage + 1;

    if (start < 1) {
      start = 1;
      end = min(totalPages, start + 1);
    }
    if (end > totalPages) {
      end = totalPages;
      start = max(1, end - 1);
    }

    pageWidgets.add(_buildPageButton(_currentPage));

    if (_currentPage < totalPages) {
      pageWidgets
        ..add(_buildPageButton(_currentPage + 1))
        ..add(const Text(KAppText.text))
        ..add(_buildPageButton(totalPages));
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
                padding: const EdgeInsets.all(KSize.kPixel16),
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
