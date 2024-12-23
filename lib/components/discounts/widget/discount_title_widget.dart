import 'package:flutter/material.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountTitleWidget extends StatefulWidget {
  const DiscountTitleWidget({
    required this.isDesk,
    required this.onViewModeChanged,
    super.key,
  });

  final bool isDesk;
  final ValueChanged<bool> onViewModeChanged;

  @override
  State<DiscountTitleWidget> createState() => _DiscountTitleWidgetState();
}

class _DiscountTitleWidgetState extends State<DiscountTitleWidget> {
  bool _isGridView = false;

  void _setGridView() {
    setState(() {
      _isGridView = true;
    });
    widget.onViewModeChanged(true);
  }

  void _setListView() {
    setState(() {
      _isGridView = false;
    });
    widget.onViewModeChanged(false);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize24),
        child: LineTitleIconWidget(
          title: context.l10n.discounts,
          rightWidget: widget.isDesk
              ? Row(
                  children: [
                    const DiscountSortingWidget(isDesk: true),
                    KSizedBox.kWidthSizedBox16,
                    IconButtonWidget(
                      icon: KIcon.gridView,
                      onPressed: _setGridView,
                      padding: KPadding.kPaddingSize12,
                      buttonStyle: KButtonStyles
                          .circularBorderNeutralButtonStyle
                          .copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          _isGridView
                              ? Colors.transparent
                              : AppColors.materialThemeKeyColorsNeutral,
                        ),
                      ),
                    ),
                    KSizedBox.kWidthSizedBox16,
                    IconButtonWidget(
                      icon: KIcon.viewAgenda,
                      onPressed: _setListView,
                      padding: KPadding.kPaddingSize12,
                      buttonStyle: KButtonStyles
                          .circularBorderNeutralButtonStyle
                          .copyWith(
                        backgroundColor: WidgetStatePropertyAll(
                          _isGridView
                              ? AppColors.materialThemeKeyColorsNeutral
                              : Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                )
              : null,
          titleKey: KWidgetkeys.screen.discounts.title,
          isDesk: widget.isDesk,
          preDividerWidget: widget.isDesk
              ? null
              : DiscountsFilterMob(
                  key: KWidgetkeys.screen.discounts.advancedFilterMob,
                ),
        ),
      ),
    );
  }
}
