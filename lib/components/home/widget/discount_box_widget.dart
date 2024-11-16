// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class DiscountBoxwWidget extends StatelessWidget {
  const DiscountBoxwWidget({required this.isTablet, super.key});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    if (isTablet) {
      return InkWell(
        hoverColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () => context.goNamed(KRoute.discounts.name),
        child: DecoratedBox(
          decoration: KWidgetTheme.boxDecorationDiscount,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize24,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: KPadding.kPaddingSize16,
                        ),
                        child: Text(
                          context.l10n.findYourDiscount,
                          style: AppTextStyle.materialThemeBodySmall,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(KPadding.kPaddingSize12),
                      child: KIcon.arrowUpRight,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: KPadding.kPaddingSize24,
                        ),
                        child: Text(
                          context.l10n.discounts,
                          style: AppTextStyle.materialThemeHeadlineLarge,
                        ),
                      ),
                    ),
                    const _DotPatternWidget(isTablet: true),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        hoverColor: Colors.transparent,
        overlayColor: const WidgetStatePropertyAll(Colors.transparent),
        onTap: () => context.goNamed(KRoute.discounts.name),
        child: DecoratedBox(
          decoration: KWidgetTheme.boxDecorationDiscount,
          child: Padding(
            padding: const EdgeInsets.only(
              left: KPadding.kPaddingSize16,
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: KPadding.kPaddingSize16,
                        ),
                        child: Text(
                          context.l10n.findYourDiscount,
                          style: AppTextStyle.materialThemeBodySmall,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(KPadding.kPaddingSize12),
                      child: KIcon.arrowUpRight,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: KPadding.kPaddingSize24,
                        ),
                        child: Text(
                          context.l10n.discounts,
                          style: AppTextStyle.materialThemeTitleLarge,
                        ),
                      ),
                    ),
                    const _DotPatternWidget(isTablet: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}

class _DotPatternWidget extends StatelessWidget {
  const _DotPatternWidget({required this.isTablet});
  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: isTablet
          ? const Size(KSize.kPixel140, KSize.kPixel140)
          : const Size(KSize.kPixel80, KSize.kPixel80),
      painter: _DotPainter(isTablet: isTablet),
    );
  }
}

class _DotPainter extends CustomPainter {
  final bool isTablet;
  _DotPainter({
    required this.isTablet,
  });
  @override
  void paint(Canvas canvas, Size size) {
    // ..color = Colors.white
    // ..style = PaintingStyle.fill;

    final dotRadius = isTablet ? 4.0 : 2.0;
    final spacing = isTablet ? 21.0 : 12.0;

    for (var i = 0; i < 7; i++) {
      for (var j = 0; j < 7; j++) {
        canvas.drawCircle(
          Offset(i * spacing, j * spacing),
          dotRadius,
          Paint()
            ..color = AppColors.materialThemeWhite
            ..style = PaintingStyle.fill,
        );
        if (i == 0 && j > 3 ||
            i == 1 && j > 4 ||
            i == 2 && j > 5 ||
            (i == 4 && j == 0) ||
            (i == 6 && j == 2) ||
            (i > 4 && j == 0) ||
            (i > 4 && j < 2) ||
            (i == 4 && j == 6) ||
            (i == 5 && j > 4) ||
            (i == 6 && j > 3)) {
          canvas.drawCircle(
            Offset(i * spacing, j * spacing),
            dotRadius,
            Paint()
              ..color = AppColors.materialThemeKeyColorsPrimary
              ..style = PaintingStyle.fill,
          );
        }
      }
    }
  }

  @override // coverage:ignore-line
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
