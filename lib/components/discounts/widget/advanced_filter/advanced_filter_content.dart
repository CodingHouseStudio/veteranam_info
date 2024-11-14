import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterContent extends StatelessWidget {
  const AdvancedFilterContent({
    required this.isDesk,
    required this.filterLocationes,
    required this.sorting,
    required this.onChange,
    required this.onChangeSorting,
    required this.chooseLocationList,
    required this.chooseSortingList,
    super.key,
  });
  final bool isDesk;
  final List<FilterItem> filterLocationes;
  final List<FilterItem> chooseLocationList;
  final List<SortingItem> sorting;
  final List<SortingItem> chooseSortingList;
  final void Function(dynamic) onChange;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    final body = [
      if (chooseLocationList.isNotEmpty || chooseSortingList.isNotEmpty)
        _ChooseItems(
          isDesk: isDesk,
          choosenList: [...chooseSortingList, ...chooseLocationList],
          onChange: onChange,
          onChangeSorting: onChangeSorting,
        ),
      Text(
        context.l10n.discount,
        key: KWidgetkeys.screen.discounts.discountText,
        style: isDesk
            ? AppTextStyle.materialThemeTitleLarge
            : AppTextStyle.materialThemeTitleMedium,
      ),
      _SortingItems(
        isDesk: isDesk,
        sorting: sorting,
        onChangeSorting: onChangeSorting,
      ),
      // ...List.generate(
      //   sorting.length,
      //   (index) => Padding(
      //     padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
      //     child: CheckPointWidget(
      //       key: KWidgetkeys.screen.discounts.discountItems,
      //       onChanged: () => onChangeSorting(sorting.elementAt(index).value),
      //       isCheck: sorting.elementAt(index).isSelected,
      //       text: sorting.elementAt(index).value.getValue(context),
      //       isDesk: isDesk,
      //     ),
      //   ),
      // ),
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.city,
        key: KWidgetkeys.screen.discounts.cityText,
        style: isDesk
            ? AppTextStyle.materialThemeTitleLarge
            : AppTextStyle.materialThemeTitleMedium,
      ),
      _LocationItems(
        filterLocationes: filterLocationes,
        onChange: onChange,
        isDesk: isDesk,
      ),
    ];
    return ListView.builder(
      key: KWidgetkeys.screen.discounts.advancedFilterList,
      primary: true,
      padding: const EdgeInsets.all(KPadding.kPaddingSize16),
      itemBuilder: (context, index) => body.elementAt(index),
      itemCount: body.length,
      semanticChildCount: body.length,
      addAutomaticKeepAlives: false,
      shrinkWrap: isDesk,
    );
  }
}

class _ChooseItems extends StatelessWidget {
  const _ChooseItems({
    required this.isDesk,
    required this.choosenList,
    required this.onChange,
    required this.onChangeSorting,
  });
  final bool isDesk;
  final List<FilterItem> choosenList;
  final void Function(dynamic) onChange;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: choosenList.length + 1,
      primary: false,
      addAutomaticKeepAlives: false,
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: KPadding.kPaddingSize24),
      itemBuilder: (context, index) {
        if (index == 0) {
          if (isDesk) {
            return Row(
              children: [
                Expanded(
                  child: Text(
                    context.l10n.filterApplied,
                    key: KWidgetkeys.screen.discounts.appliedFilterText,
                    style: AppTextStyle.materialThemeTitleLarge,
                  ),
                ),
                AdvancedFilterResetButton(
                  isDesk: true,
                  resetEvent: () => context
                      .read<DiscountWatcherBloc>()
                      .add(const DiscountWatcherEvent.filterReset()),
                ),
              ],
            );
          } else {
            return Text(
              context.l10n.filterApplied,
              key: KWidgetkeys.screen.discounts.appliedFilterText,
              style: AppTextStyle.materialThemeTitleMedium,
            );
          }
        }
        final chooseItem = choosenList.elementAt(index - 1);
        return Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CancelChipWidget(
              widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
              isDesk: isDesk,
              labelText: choosenList.elementAt(index - 1).getString(context),
              // filter is SubLocation
              //     ? filter.getList(context).first
              //     : filter is DiscountEnum
              //         ? filter.getValue(context)
              //         : (filter as FilterItem).getString(context),
              onPressed: () {
                // if (filter is DiscountEnum) {
                //   onChangeSorting(filter);
                // } else {
                onChange(
                  chooseItem.value,
                );
                // }
              },
            ),
          ),
        );
      },
    );
  }
}

class _SortingItems extends StatelessWidget {
  const _SortingItems({
    required this.isDesk,
    required this.sorting,
    required this.onChangeSorting,
  });
  final bool isDesk;
  final List<SortingItem> sorting;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      itemCount: sorting.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
        child: CheckPointWidget(
          key: KWidgetkeys.screen.discounts.discountItems,
          onChanged: () => onChangeSorting(sorting.elementAt(index).value),
          isCheck: sorting.elementAt(index).isSelected,
          text: sorting.elementAt(index).value.getValue(context),
          isDesk: isDesk,
        ),
      ),
    );
  }
}

class _LocationItems extends StatelessWidget {
  const _LocationItems({
    required this.filterLocationes,
    required this.onChange,
    required this.isDesk,
  });
  final List<FilterItem> filterLocationes;
  final void Function(dynamic) onChange;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: filterLocationes.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
        child: CheckPointAmountWidget(
          key: KWidgetkeys.screen.discounts.cityItems,
          onChanged: () => onChange(
            filterLocationes.elementAt(index).value,
          ),
          isCheck: filterLocationes.elementAt(index).isSelected,
          filterItem: filterLocationes.elementAt(index),
          isDesk: isDesk,
          amoutInactiveClor: isDesk ? null : AppColors.materialThemeWhite,
        ),
      ),
    );
  }
}
