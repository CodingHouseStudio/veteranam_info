import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FiltersChipWidget extends StatelessWidget {
  const FiltersChipWidget({
    required this.filtersItems,
    required this.isDesk,
    // required this.onResetValue,
    required this.onSelected,
    required this.isSelected,
    required this.fullLength,
    required this.filterIsEmpty,
    super.key,
  });

  final List<FilterItem> filtersItems;
  final int fullLength;
  final bool isDesk;
  final bool filterIsEmpty;
  // final void Function() onResetValue;
  final void Function(
    dynamic value,
  ) onSelected;
  final bool Function(
    dynamic value,
  )? isSelected;

  @override
  Widget build(BuildContext context) {
    return isDesk
        ? ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  AppColors.materialThemeWhite,
                  AppColors.materialThemeWhite.withOpacity(0.03),
                ],
                stops: const [0.8, 1],
                tileMode: TileMode.mirror,
              ).createShader(bounds);
            },
            child: _FilterChipBodyWidget(
              filtersItems: filtersItems,
              fullLength: fullLength,
              isDesk: isDesk,
              filterIsEmpty: filterIsEmpty,
              onSelected: onSelected,
              isSelected: isSelected,
            ),
          )
        : _FilterChipBodyWidget(
            filtersItems: filtersItems,
            fullLength: fullLength,
            isDesk: isDesk,
            filterIsEmpty: filterIsEmpty,
            onSelected: onSelected,
            isSelected: isSelected,
          );
    //     ),
    //   ],
    // );
  }
}

class _FilterChipBodyWidget extends StatelessWidget {
  const _FilterChipBodyWidget({
    required this.filtersItems,
    required this.fullLength,
    required this.isDesk,
    required this.filterIsEmpty,
    required this.onSelected,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  final List<FilterItem> filtersItems;
  final int fullLength;
  final bool isDesk;
  final bool filterIsEmpty;
  // final void Function() onResetValue;
  final void Function(
    dynamic value,
  ) onSelected;
  final bool Function(
    dynamic value,
  )? isSelected;

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
          itemCount: filtersItems.length,
          itemBuilder: (context, index) {
            final filterItem = filtersItems.elementAt(index);
            if (index == 0) {
              return Row(
                key: ValueKey(filterItem),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: isDesk
                          ? KPadding.kPaddingSize16
                          : KPadding.kPaddingSize8,
                    ),
                    child: ChipWidget(
                      key: KWidgetkeys.widget.filterChip.chips,
                      filter: FilterItem(
                        CategoryEnum.all.getValue(context),
                        number: fullLength,
                      ),
                      onSelected: (isSelected) => onSelected(
                        CategoryEnum.all,
                      ),
                      isSelected: (isSelected?.call(
                                CategoryEnum.all,
                              ) ??
                              false) ||
                          filterIsEmpty,
                      isDesk: isDesk,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: isDesk
                          ? KPadding.kPaddingSize16
                          : KPadding.kPaddingSize8,
                    ),
                    child: ChipWidget(
                      key: KWidgetkeys.widget.filterChip.chips,
                      filter: filterItem,
                      onSelected: (isSelected) => onSelected(
                        filterItem.value,
                      ),
                      isSelected: isSelected?.call(
                            filterItem.value,
                          ) ??
                          //Discount
                          filterItem.isSelected,
                      isDesk: isDesk,
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                key: ValueKey(filterItem),
                padding: EdgeInsets.only(
                  right:
                      isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
                ),
                child: ChipWidget(
                  key: KWidgetkeys.widget.filterChip.chips,
                  filter: filterItem,
                  onSelected: (isSelected) => onSelected(
                    filterItem.value,
                  ),
                  isSelected: isSelected?.call(
                        filtersItems.elementAt(index).value,
                      ) ??
                      //Discount
                      filterItem.isSelected,
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
