import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterContent extends StatelessWidget {
  const AdvancedFilterContent({
    required this.isDesk,
    required this.filterLocationes,
    required this.onLocationChange,
    required this.chooseLocationList,
    required this.filterCategories,
    required this.chooseCategoriesList,
    required this.onCategoriesChange,
    required this.filterEligibilities,
    required this.chooseEligibilitiesList,
    required this.onEligibilitiesChange,
    super.key,
  });
  final bool isDesk;
  final List<FilterItem<String>> filterLocationes;
  final List<FilterItem<String>> chooseLocationList;
  final List<FilterItem<String>> filterCategories;
  final List<FilterItem<String>> chooseCategoriesList;
  final List<FilterItem<String>> filterEligibilities;
  final List<FilterItem<String>> chooseEligibilitiesList;
  final void Function(String) onEligibilitiesChange;
  final void Function(String) onCategoriesChange;
  final void Function(String) onLocationChange;

  @override
  Widget build(BuildContext context) {
    final body = [
      if (chooseLocationList.isNotEmpty ||
          chooseCategoriesList.isNotEmpty ||
          chooseEligibilitiesList.isNotEmpty) ...[
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
            choosenItems: [
              ...chooseEligibilitiesList,
              ...chooseCategoriesList,
              ...chooseLocationList,
            ],
            categoriesLength: chooseCategoriesList.length,
            onChangeLocation: onLocationChange,
            onChangeCategories: onCategoriesChange,
            eligibilitiesLength: chooseEligibilitiesList.length,
            onChangeEligibilities: onEligibilitiesChange,
          ),
        ),
      ],
      AdvancedFilterListWidget(
        isDesk: isDesk,
        list: _AdvancedListWidget(
          filter: filterEligibilities,
          onChange: onEligibilitiesChange,
          isDesk: isDesk,
          itemKey: KWidgetkeys.screen.discounts.eligibilitiesItems,
        ),
        textKey: KWidgetkeys.screen.discounts.eligibilitiesText,
        title: context.l10n.eligibility,
      ),
      AdvancedFilterListWidget(
        isDesk: isDesk,
        list: _AdvancedListWidget(
          filter: filterCategories,
          onChange: onCategoriesChange,
          isDesk: isDesk,
          itemKey: KWidgetkeys.screen.discounts.categoriesItems,
        ),
        textKey: KWidgetkeys.screen.discounts.categoriesText,
        title: context.l10n.category,
      ),
      // SliverPadding(
      //   padding: const EdgeInsets.only(right: KPadding.kPaddingSize8),
      //   sliver: SliverToBoxAdapter(
      //     child: Text(
      //       context.l10n.discount,
      //       key: KWidgetkeys.screen.discounts.discountText,
      //       style: isDesk
      //           ? AppTextStyle.materialThemeTitleLarge
      //           : AppTextStyle.materialThemeTitleMedium,
      //     ),
      //   ),
      // ),
      // SliverPadding(
      //   padding: const EdgeInsets.only(
      //     bottom: KPadding.kPaddingSize24,
      //     right: KPadding.kPaddingSize8,
      //   ),
      //   sliver: _SortingFilterItems(
      //     isDesk: isDesk,
      //     sorting: sorting,
      //     onChangeSorting: onChangeSorting,
      //   ),
      // ),
      AdvancedFilterListWidget(
        isDesk: isDesk,
        list: _AdvancedListWidget(
          filter: filterLocationes,
          onChange: onLocationChange,
          isDesk: isDesk,
          itemKey: KWidgetkeys.screen.discounts.cityItems,
        ),
        textKey: KWidgetkeys.screen.discounts.citiesText,
        title: context.l10n.city,
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

class _AdvancedListWidget extends StatelessWidget {
  const _AdvancedListWidget({
    required this.filter,
    required this.onChange,
    required this.isDesk,
    required this.itemKey,
  });
  final List<FilterItem<String>> filter;
  final void Function(String) onChange;
  final bool isDesk;
  final Key itemKey;

  @override
  Widget build(BuildContext context) {
    return SliverPrototypeExtentList.builder(
      prototypeItem: Padding(
        padding: isDesk
            ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
            : EdgeInsets.zero,
        child: CheckPointAmountWidget(
          key: itemKey,
          isCheck: false,
          filterItem: FilterItem(KMockText.category, number: 10),
          isDesk: isDesk,
          onChanged: null,
        ),
      ),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: filter.length,
      findChildIndexCallback: (key) {
        if (key is ValueKey<String>) {
          final valueKey = key;
          return filter.indexWhere(
            (element) => element.value == valueKey.value,
          );
        }
        return null;
      },
      itemBuilder: (context, index) => Padding(
        key: ValueKey(filter.elementAt(index).value),
        padding: isDesk
            ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
            : EdgeInsets.zero,
        child: CheckPointAmountWidget(
          key: itemKey,
          onChanged: () => onChange(
            filter.elementAt(index).value,
          ),
          isCheck: filter.elementAt(index).isSelected,
          filterItem: filter.elementAt(index),
          isDesk: isDesk,
          amoutInactiveClor: isDesk ? null : AppColors.materialThemeWhite,
        ),
      ),
    );
  }
}

class _ChooseItems extends StatelessWidget {
  const _ChooseItems({
    required this.isDesk,
    required this.choosenItems,
    required this.onChangeLocation,
    required this.onChangeCategories,
    required this.categoriesLength,
    required this.eligibilitiesLength,
    required this.onChangeEligibilities,
  });
  final bool isDesk;
  final List<FilterItem<String>> choosenItems;
  final int categoriesLength;
  final int eligibilitiesLength;
  final void Function(String) onChangeLocation;
  final void Function(String) onChangeCategories;
  final void Function(String) onChangeEligibilities;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.only(
        bottom: isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize8,
      ),
      sliver: SliverPrototypeExtentList.builder(
        prototypeItem: Padding(
          padding: isDesk
              ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
              : EdgeInsets.zero,
          child: CancelChipWidget(
            widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
            isDesk: isDesk,
            labelText: KMockText.category,
            onPressed: null,
          ),
        ),
        itemCount: choosenItems.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: false,
        itemBuilder: (context, index) {
          final chooseItem = choosenItems.elementAt(index);
          return Padding(
            padding: isDesk
                ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
                : EdgeInsets.zero,
            child: Align(
              alignment: Alignment.centerLeft,
              child: CancelChipWidget(
                widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
                isDesk: isDesk,
                labelText: chooseItem.getString(context),
                onPressed: () {
                  if (eligibilitiesLength < index) {
                    onChangeEligibilities(chooseItem.value);
                  } else if (eligibilitiesLength + categoriesLength < index) {
                    onChangeCategories(chooseItem.value);
                  } else {
                    onChangeLocation(
                      chooseItem.value,
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

// class _SortingFilterItems extends StatelessWidget {
//   const _SortingFilterItems({
//     required this.isDesk,
//     required this.sorting,
//     required this.onChangeSorting,
//   });
//   final bool isDesk;
//   final List<FilterItem<DiscountEnum>> sorting;
//   final void Function(DiscountEnum) onChangeSorting;

//   @override
//   Widget build(BuildContext context) {
//     return SliverPrototypeExtentList.builder(
//       prototypeItem: Padding(
//         padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
//         child: CheckPointWidget(
//           key: KWidgetkeys.screen.discounts.discountItems,
//           onChanged: null,
//           isCheck: false,
//           text: KMockText.category,
//           isDesk: isDesk,
//         ),
//       ),
//       addAutomaticKeepAlives: false,
//       addRepaintBoundaries: false,
//       itemCount: sorting.length,
//       itemBuilder: (context, index) => Padding(
//         padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
//         child: CheckPointWidget(
//           key: KWidgetkeys.screen.discounts.discountItems,
//           onChanged: () => onChangeSorting(sorting.elementAt(index).value),
//           isCheck: sorting.elementAt(index).isSelected,
//           text: sorting.elementAt(index).value.getValue(context),
//           isDesk: isDesk,
//         ),
//       ),
//     );
//   }
// }
