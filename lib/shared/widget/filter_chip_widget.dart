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
    return Align(
      alignment: Alignment.centerLeft,
      child: ScrollConfiguration(
        behavior: CustomScrollBehavior(),
        child: SizedBox(
          height: KSize.kPixel48,
          child: ListView.builder(
            key: FilterChipKeys.widget,
            scrollDirection: Axis.horizontal,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            // primary: true,
            itemCount: filtersItems.isEmpty
                ? KDimensions.shimmerCategoryItems
                : filtersItems.length + 1,
            // We use it only in ifformation page
            // findChildIndexCallback: (key) {
            //   if (key is ValueKey) {
            //     if (key is ValueKey<String> &&
            //         key.value.contains('mock_category_')) {
            //       final valueKey = key;
            //       final mockValue = int.tryParse(
            //         valueKey.value.replaceAll('mock_category_', ''),
            //       );
            //       return mockValue;
            //     }
            //     final valueKey = key;
            //     if (valueKey is ValueKey<CategoryEnum>) {
            //       return 0;
            //     }
            //     final index = filtersItems.indexWhere(
            //       (element) => element.value == valueKey.value,
            //     );
            //     if (index >= 0) {
            //       return filtersItems.indexWhere(
            //             (element) => element.value == valueKey.value,
            //           ) +
            //           1;
            //     }
            //   }
            //   return null;
            // },
            restorationId: 'category',
            itemBuilder: (context, index) => _FilterChipItemWidget(
              filtersItems: filtersItems,
              isDesk: isDesk,
              index: index,
              fullLength: fullLength,
              filterIsEmpty: filterIsEmpty,
              onSelected: onSelected,
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterChipItemWidget extends StatelessWidget {
  const _FilterChipItemWidget({
    required this.filtersItems,
    required this.isDesk,
    required this.index,
    required this.fullLength,
    required this.filterIsEmpty,
    required this.onSelected,
  });
  final List<FilterItem> filtersItems;
  final bool isDesk;
  final int index;
  final int fullLength;
  final bool filterIsEmpty;
  final void Function(dynamic value) onSelected;

  @override
  Widget build(BuildContext context) {
    {
      if (filtersItems.isEmpty) {
        return SkeletonizerWidget(
          isLoading: true,
          child: Padding(
            key: ValueKey('mock_category_$index'),
            padding: EdgeInsets.only(
              right: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
            ),
            child: ChipWidget(
              filter: const FilterItem(
                KMockText.category,
              ),
              onSelected: null,
              isSelected: false,
              isDesk: isDesk,
            ),
          ),
        );
      }
      if (index == 0) {
        return Padding(
          key: const ValueKey(CategoryEnum.all),
          padding: EdgeInsets.only(
            right: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
          ),
          child: ChipWidget(
            filter: FilterItem(
              CategoryEnum.all.getValue,
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
            right: isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
          ),
          child: ChipWidget(
            key: FilterChipKeys.chips,
            filter: filterItem,
            onSelected: (isSelected) => onSelected(filterItem.value),
            isSelected: filterItem.isSelected,
            isDesk: isDesk,
          ),
        );
      }
    }
  }
}
