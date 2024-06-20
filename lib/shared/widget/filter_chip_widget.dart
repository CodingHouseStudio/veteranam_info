import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class FiltersChipWidget extends StatelessWidget {
  const FiltersChipWidget({
    required this.filtersItems,
    required this.isDesk,
    // required this.onResetValue,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  final List<FilterItem> filtersItems;
  final bool isDesk;
  // final void Function() onResetValue;
  final void Function(
    int index,
  ) onSelected;
  final bool Function(
    int index,
  ) isSelected;

  @override
  Widget build(BuildContext context) {
    // return Row(
    //   key: KWidgetkeys.widget.filterChip.widget,
    //   children: [
    //     FilterPopupMenuWidget(
    //       key: KWidgetkeys.widget.filterChip.popup,
    //       onResetValue: onResetValue,
    //       isDesk: isDesk,
    //     ),
    //     KSizedBox.kWidthSizedBox24,
    //     Expanded(
    //       child:
    return isDesk
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  AppColors.materialThemeWhite,
                  AppColors.materialThemeWhite.withOpacity(0.03),
                ],
                stops: const [0.6, 1],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: _body,
          )
        : _body;
    //     ),
    //   ],
    // );
  }

  Widget get _body => SingleChildScrollView(
        key: KWidgetkeys.widget.filterChip.widget,
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(filtersItems.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                right:
                    isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
              ),
              child: ChipWidget(
                key: KWidgetkeys.widget.filterChip.chips,
                filter: filtersItems.elementAt(index),
                onSelected: (isSelected) => onSelected(
                  index,
                ),
                isSelected: isSelected(
                  index,
                ),
                isDesk: isDesk,
              ),
            );
          }),
        ),
      );
}
