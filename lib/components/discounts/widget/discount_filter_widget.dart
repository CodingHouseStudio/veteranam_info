import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/discounts/bloc/discount_watcher_bloc.dart';
import 'package:kozak/shared/shared.dart';

class DiscountFilters extends StatelessWidget {
  const DiscountFilters({
    required this.filtersItem,
    required this.isDesk,
    super.key,
  });

  final List<String> filtersItem;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FilterPopupMenuWidget(
          onResetValue: () => context.read<DiscountWatcherBloc>().add(
                const DiscountWatcherEvent.filterReset(),
              ),
        ),
        KSizedBox.kWidthSizedBox24,
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filtersItem.map((filter) {
                return Padding(
                  padding: EdgeInsets.only(
                    right: isDesk
                        ? KPadding.kPaddingSize16
                        : KPadding.kPaddingSize8,
                  ),
                  child: ChipWidget(
                    key: KWidgetkeys.widget.dropChip.widget,
                    filter: filter,
                    onSelected: ({required isSelected}) =>
                        context.read<DiscountWatcherBloc>().add(
                              DiscountWatcherEvent.filter(
                                filter: filter,
                                isSelected: isSelected,
                              ),
                            ),
                    isSelected: context
                            .read<DiscountWatcherBloc>()
                            .state
                            .filters
                            ?.contains(filter) ??
                        false,
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
