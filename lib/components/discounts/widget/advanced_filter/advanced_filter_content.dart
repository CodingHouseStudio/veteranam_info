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
  final List<FilterItem<String>> filterLocationes;
  final List<FilterItem<String>> chooseLocationList;
  final List<FilterItem<DiscountEnum>> sorting;
  final List<FilterItem<DiscountEnum>> chooseSortingList;
  final void Function(String) onChange;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    final body = [
      if (chooseLocationList.isNotEmpty || chooseSortingList.isNotEmpty) ...[
        if (isDesk)
          SliverToBoxAdapter(
            child: AdvancedFilterResetButton(
              isDesk: true,
              resetEvent: () => context
                  .read<DiscountWatcherBloc>()
                  .add(const DiscountWatcherEvent.filterReset()),
            ),
          )
        else
          SliverToBoxAdapter(
            child: Text(
              context.l10n.filterApplied,
              key: KWidgetkeys.screen.discounts.appliedFilterText,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
          sliver: _ChooseItems(
            isDesk: isDesk,
            choosenList: [...chooseSortingList, ...chooseLocationList],
            onChange: onChange,
            onChangeSorting: onChangeSorting,
          ),
        ),
      ],
      SliverPadding(
        padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
        sliver: SliverToBoxAdapter(
          child: Text(
            context.l10n.discount,
            key: KWidgetkeys.screen.discounts.discountText,
            style: isDesk
                ? AppTextStyle.materialThemeTitleLarge
                : AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(
          bottom: KPadding.kPaddingSize24,
          right: KPadding.kPaddingSize8,
        ),
        sliver: _FilterItems(
          isDesk: isDesk,
          sorting: sorting,
          onChangeSorting: onChangeSorting,
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
        sliver: SliverToBoxAdapter(
          child: Text(
            context.l10n.city,
            key: KWidgetkeys.screen.discounts.cityText,
            style: isDesk
                ? AppTextStyle.materialThemeTitleLarge
                : AppTextStyle.materialThemeTitleMedium,
          ),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
        sliver: _LocationItems(
          filterLocationes: filterLocationes,
          onChange: onChange,
          isDesk: isDesk,
        ),
      ),
    ];
    return Padding(
      padding: isDesk
          ? const EdgeInsets.only(right: KPadding.kPaddingSize16)
          : const EdgeInsets.all(KPadding.kPaddingSize16),
      child: CustomScrollView(
        key: KWidgetkeys.screen.discounts.advancedFilterList,
        primary: true,
        slivers: body,
        shrinkWrap: isDesk,
      ),
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
  final List<FilterItem<dynamic>> choosenList;
  final void Function(String) onChange;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(bottom: KPadding.kPaddingSize24),
      sliver: SliverPrototypeExtentList.builder(
        prototypeItem: Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: CancelChipWidget(
            widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
            isDesk: isDesk,
            labelText: KMockText.category,
            onPressed: null,
          ),
        ),
        itemCount: choosenList.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (context, index) {
          final chooseItem = choosenList.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CancelChipWidget(
                widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
                isDesk: isDesk,
                labelText: chooseItem.getString(context),
                onPressed: () {
                  if (chooseItem.value is DiscountEnum) {
                    onChangeSorting(chooseItem.value as DiscountEnum);
                  } else {
                    onChange(
                      chooseItem.value as String,
                    );
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FilterItems extends StatelessWidget {
  const _FilterItems({
    required this.isDesk,
    required this.sorting,
    required this.onChangeSorting,
  });
  final bool isDesk;
  final List<FilterItem<DiscountEnum>> sorting;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    return SliverPrototypeExtentList.builder(
      prototypeItem: Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
        child: CheckPointWidget(
          key: KWidgetkeys.screen.discounts.discountItems,
          onChanged: null,
          isCheck: false,
          text: KMockText.category,
          isDesk: isDesk,
        ),
      ),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
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
  final List<FilterItem<String>> filterLocationes;
  final void Function(String) onChange;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return SliverPrototypeExtentList.builder(
      prototypeItem: Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
        child: CheckPointAmountWidget(
          key: KWidgetkeys.screen.discounts.cityItems,
          isCheck: false,
          filterItem: FilterItem(KMockText.category, number: 10),
          isDesk: isDesk,
          onChanged: null,
        ),
      ),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: filterLocationes.length,
      findChildIndexCallback: (key) {
        if (key is ValueKey<String>) {
          final valueKey = key;
        }
        return null;
      },
      itemBuilder: (context, index) => Padding(
        key: ValueKey(filterLocationes.elementAt(index).value),
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
