import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class FiltersChipWidget extends StatelessWidget {
  const FiltersChipWidget({
    required this.filtersItems,
    required this.isDesk,
    required this.onResetValue,
    required this.onSelected,
    required this.isSelected,
    super.key,
  });

  final List<String> filtersItems;
  final bool isDesk;
  final void Function() onResetValue;
  final void Function(
    int inde,
  ) onSelected;
  final bool Function({
    required String filter,
    required List<String> filtersItems,
  }) isSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: KWidgetkeys.widget.filterChip.widget,
      children: [
        FilterPopupMenuWidget(
          key: KWidgetkeys.widget.filterChip.popup,
          onResetValue: onResetValue,
          isDesk: isDesk,
        ),
        KSizedBox.kWidthSizedBox24,
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filtersItems.map((filter) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: isDesk
                        ? KPadding.kPaddingSize16
                        : KPadding.kPaddingSize8,
                  ),
                  child: ChipWidget(
                    key: KWidgetkeys.widget.filterChip.chips,
                    filter: filter,
                    onSelected: ({required isSelected}) =>
                        onSelected(filtersItems.indexOf(filter)),
                    isSelected:
                        isSelected(filter: filter, filtersItems: filtersItems),
                    isDesk: isDesk,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
