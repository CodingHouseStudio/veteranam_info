import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    required this.pages,
    required this.currentPage,
    required this.changePage,
    super.key,
  });

  final int pages;
  final int currentPage;
  final void Function(int page) changePage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TextButton.icon(
            key: KWidgetkeys.widget.pagination.buttonPrevious,
            label: const Text(KMockText.previousPage),
            onPressed:
                currentPage > 1 ? () => changePage(currentPage - 1) : null,
            style: KButtonStyles.transparentButtonStyle,
            icon: KIcon.arrowLeft,
          ),
          KSizedBox.kWidthSizedBox16,
          if (pages >= 10 && currentPage < 6)
            ...List.generate(
              9,
              (index) => _buildPageButton(index + 1),
            )
              ..add(const Text('...'))
              ..add(_buildPageButton(pages))
          else if (currentPage >= 6 && pages - currentPage > 3) ...[
            _buildPageButton(1),
            const Text('...'),
            ...List.generate(
              7,
              (index) => _buildPageButton(currentPage - 4 + index),
            ),
            const Text('...'),
            _buildPageButton(pages),
          ] else if (pages - currentPage <= 3) ...[
            _buildPageButton(1),
            const Text('...'),
            ...List.generate(
              8,
              (index) => _buildPageButton(pages - 7 + index),
            ),
          ] else
            ...List.generate(
              pages,
              (index) => _buildPageButton(index + 1),
            ),
          KSizedBox.kWidthSizedBox8,
          TextButton(
            key: KWidgetkeys.widget.pagination.buttonNext,
            onPressed:
                pages > currentPage ? () => changePage(currentPage + 1) : null,
            style: KButtonStyles.transparentButtonStyle,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(KMockText.nextPage),
                KIcon.arrowRight,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(int pageNumber) {
    return Padding(
      padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => changePage(pageNumber),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
            vertical: KPadding.kPaddingSize6_5,
          ),
          decoration: KWidgetTheme.boxDecorationCircular.copyWith(
            color: currentPage == pageNumber
                ? AppColors.widgetBackground
                : AppColors.transparent,
          ),
          child: Text(
            pageNumber.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyle.text20,
          ),
        ),
      ),
    );
  }
}
