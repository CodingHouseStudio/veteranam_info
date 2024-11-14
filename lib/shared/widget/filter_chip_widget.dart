import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FilterChipBodyWidget extends StatelessWidget {
  const FilterChipBodyWidget({
    required this.filtersItems,
    required this.fullLength,
    required this.isDesk,
    required this.filterIsEmpty,
    required this.onSelected,
    super.key,
  });

  final List<FilterItem> filtersItems;
  final int fullLength;
  final bool isDesk;
  final bool filterIsEmpty;
  final void Function(dynamic value) onSelected;
  // final void Function() onResetValue;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: CustomScrollBehavior(),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          key: KWidgetkeys.widget.filterChip.widget,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          primary: true,
          itemCount: filtersItems.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.only(
                  right:
                      isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
                ),
                child: ChipWidget(
                  filter: FilterItem(
                    CategoryEnum.all.getValue(context),
                    number: fullLength,
                  ),
                  onSelected: (isSelected) => onSelected(CategoryEnum.all),
                  isSelected: filterIsEmpty,
                  isDesk: isDesk,
                ),
              );
            } else {
              final filterItem = filtersItems.elementAt(index - 1);
              return Padding(
                key: ValueKey(filterItem.value),
                padding: EdgeInsets.only(
                  right:
                      isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
                ),
                child: ChipWidget(
                  key: KWidgetkeys.widget.filterChip.chips,
                  filter: filterItem,
                  onSelected: (isSelected) => onSelected(filterItem.value),
                  isSelected: filterItem.isSelected,
                  isDesk: isDesk,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
