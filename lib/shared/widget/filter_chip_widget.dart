import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

import '../../components/discounts/bloc/watcher/discount_watcher_bloc.dart';

class FilterChipBodyWidget extends StatelessWidget {
  const FilterChipBodyWidget({
    required this.filtersItems,
    required this.fullLength,
    required this.isDesk,
    required this.filterIsEmpty,
    Key? key,
  }) : super(key: key);

  final List<FilterItem> filtersItems;
  final int fullLength;
  final bool isDesk;
  final bool filterIsEmpty;
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
          itemCount: filtersItems.length,
          itemBuilder: (context, index) {
            final filterItem = filtersItems.elementAt(index);
            if (index == 0) {
              return Row(
                key: ObjectKey(filterItem),
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: isDesk
                          ? KPadding.kPaddingSize16
                          : KPadding.kPaddingSize8,
                    ),
                    child: ChipWidget(
                      filter: FilterItem(
                        CategoryEnum.all.getValue(context),
                        number: fullLength,
                      ),
                      onSelected: (isSelected) =>
                          context.read<DiscountWatcherBloc>().add(
                                const DiscountWatcherEvent.filterCategory(
                                  CategoryEnum.all,
                                ),
                              ),
                      isSelected: filterIsEmpty,
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
                      key: UniqueKey(),
                      filter: filterItem,
                      onSelected: (isSelected) =>
                          context.read<DiscountWatcherBloc>().add(
                                DiscountWatcherEvent.filterCategory(
                                  filterItem.value,
                                ),
                              ),
                      isSelected: filterItem.isSelected,
                      isDesk: isDesk,
                    ),
                  ),
                ],
              );
            } else {
              return Padding(
                key: ValueKey(filterItem.value),
                padding: EdgeInsets.only(
                  right:
                      isDesk ? KPadding.kPaddingSize16 : KPadding.kPaddingSize8,
                ),
                child: ChipWidget(
                  key: KWidgetkeys.widget.filterChip.chips,
                  filter: filterItem,
                  onSelected: (isSelected) =>
                      context.read<DiscountWatcherBloc>().add(
                            DiscountWatcherEvent.filterCategory(
                              filterItem.value,
                            ),
                          ),
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
