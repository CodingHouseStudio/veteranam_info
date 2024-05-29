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
            label: Text(context.l10n.previous),
            onPressed:
                currentPage > 1 ? () => changePage(currentPage - 1) : null,
            style: KButtonStyles.transparentButtonStyle,
            icon: KIcon.arrowLeft,
          ),
          KSizedBox.kWidthSizedBox16,
          if (pages > 1) ...[
            _buildPageButton(
              context: context,
              pageNumber: 1,
              key: KWidgetkeys.widget.pagination.firstNumber,
            ),
            if (pages > 10 && currentPage >= 6)
              Text(
                '...',
                key: KWidgetkeys.widget.pagination.firstThreePoint,
              ),
            ...List.generate(
              7,
              (index) {
                final number = pages >= 10 && currentPage < 6
                    ? index + 2
                    : currentPage >= 6 && pages - currentPage > 3
                        ? currentPage - 4 + index
                        : pages - 7 + index;
                return _buildPageButton(
                  pageNumber: number,
                  key: number == 6
                      ? KWidgetkeys.widget.pagination.sixthNumber
                      : KWidgetkeys.widget.pagination.numbers,
                  context: context,
                );
              },
            ),
          ],
          if (pages - currentPage > 3)
            Text(
              '...',
              key: KWidgetkeys.widget.pagination.lastThreePoint,
            ),
          _buildPageButton(
            context: context,
            pageNumber: pages,
            key: KWidgetkeys.widget.pagination.lastNumber,
          ),
          KSizedBox.kWidthSizedBox8,
          TextButton(
            key: KWidgetkeys.widget.pagination.buttonNext,
            onPressed:
                pages > currentPage ? () => changePage(currentPage + 1) : null,
            style: KButtonStyles.transparentButtonStyle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(context.l10n.next),
                KIcon.arrowRight,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton({
    required int pageNumber,
    required BuildContext context,
    Key? key,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
      child: InkWell(
        key: key,
        borderRadius: BorderRadius.circular(50),
        onTap: () => changePage(pageNumber),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: KPadding.kPaddingSize16,
            vertical: KPadding.kPaddingSize6_5,
          ),
          decoration: KWidgetTheme.boxDecorationCircular.copyWith(
            color: currentPage == pageNumber
                ? AppColors.materialThemeKeyColorsNeutralVariant
                : null,
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
