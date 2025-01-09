import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discounts_watcher_bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterContent extends StatelessWidget {
  const AdvancedFilterContent({
    required this.isDesk,
    // required this.onLocationChange,
    // required this.onCategoriesChange,
    // required this.onEligibilitiesChange,
    // required this.discountFilter,
    super.key,
  });
  final bool isDesk;
  // final IDiscountFilterRepository discountFilter;
  // final void Function(String) onEligibilitiesChange;
  // final void Function(String) onCategoriesChange;
  // final void Function(String) onLocationChange;

  @override
  Widget build(BuildContext context) {
    final body = [
      if (isDesk)
        BlocSelector<
            DiscountsWatcherBloc,
            DiscountsWatcherState,
            ({
              Map<String, FilterItem> chosenItems,
              int categoriesLength,
              int eligibilitiesLength,
            })>(
          selector: (state) => (
            chosenItems: state.discountFilterRepository.getActivityList,
            categoriesLength:
                state.discountFilterRepository.activeCategoryMap.length,
            eligibilitiesLength:
                state.discountFilterRepository.activeEligibilityMap.length,
          ),
          // buildWhen: (previous, current) =>
          //     previous.discountFilterRepository.getActivityList !=
          //         current.discountFilterRepository.getActivityList ||
          //     previous.filterStatus != current.filterStatus,
          builder: (context, state) {
            if (state.chosenItems.isNotEmpty) {
              return SliverMainAxisGroup(
                slivers: [
                  if (isDesk)
                    SliverToBoxAdapter(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: AdvancedFilterResetButton(
                          isDesk: true,
                          resetEvent: () => context
                              .read<DiscountsWatcherBloc>()
                              .add(const DiscountsWatcherEvent.filterReset()),
                        ),
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
                    padding:
                        const EdgeInsets.only(right: KPadding.kPaddingSize8),
                    sliver: _ChooseItems(
                      isDesk: isDesk,
                      chosenItems: state.chosenItems,
                      categoriesLength: state.categoriesLength,
                      eligibilitiesLength: state.eligibilitiesLength,
                    ),
                  ),
                ],
              );
            } else {
              return const SliverToBoxAdapter();
            }
          },
        ),
      BlocSelector<
          DiscountsWatcherBloc,
          DiscountsWatcherState,
          ({
            Map<String, FilterItem> eligibilityMap,
            FilterItem? firstActiveItem,
            bool isLoading,
            FilterStatus filterStatus,
          })>(
        selector: (state) => (
          eligibilityMap: state.discountFilterRepository.eligibilityMap,
          isLoading: state.filterStatus.isLoading,
          firstActiveItem:
              state.discountFilterRepository.activeEligibilityMap.first,
          filterStatus: state.filterStatus,
        ),
        // buildWhen: (previous, current) =>
        //     previous.discountFilterRepository.eligibilityMap !=
        //         current.discountFilterRepository.eligibilityMap ||
        //     previous.filterStatus != current.filterStatus,
        builder: (context, state) {
          if (state.eligibilityMap.isNotEmpty || state.isLoading) {
            return AdvancedFilterListWidget(
              isDesk: isDesk,
              list: _AdvancedListWidget(
                filter: state.eligibilityMap,
                onChange: (value) => context.read<DiscountsWatcherBloc>().add(
                      DiscountsWatcherEvent.filterEligibilities(
                        eligibility: value,
                        isDesk: isDesk,
                      ),
                    ),
                isDesk: isDesk,
                itemKey: KWidgetkeys.screen.discounts.eligibilitiesItems,
                isLoading: state.isLoading,
              ),
              textKey: KWidgetkeys.screen.discounts.eligibilitiesText,
              title: context.l10n.eligibility,
              value: state.firstActiveItem,
              onCancelWidgetPressed: (value) =>
                  context.read<DiscountsWatcherBloc>().add(
                        DiscountsWatcherEvent.filterEligibilities(
                          eligibility: value,
                          isDesk: isDesk,
                        ),
                      ),
              isLoading: state.isLoading,
            );
          } else {
            return const SliverToBoxAdapter();
          }
        },
      ),
      BlocSelector<
          DiscountsWatcherBloc,
          DiscountsWatcherState,
          ({
            Map<String, FilterItem> categoryMap,
            FilterItem? firstActiveItem,
            bool isLoading,
            FilterStatus filterStatus,
          })>(
        selector: (state) => (
          categoryMap: state.discountFilterRepository.categoryMap,
          isLoading: state.filterStatus.isLoading,
          firstActiveItem:
              state.discountFilterRepository.activeCategoryMap.first,
          filterStatus: state.filterStatus,
        ),
        // buildWhen: (previous, current) =>
        //     previous.discountFilterRepository.categoryMap !=
        //         current.discountFilterRepository.categoryMap ||
        //     previous.filterStatus != current.filterStatus,
        builder: (context, state) {
          if (state.categoryMap.isNotEmpty || state.isLoading) {
            return AdvancedFilterListWidget(
              isDesk: isDesk,
              list: _AdvancedListWidget(
                filter: state.categoryMap,
                onChange: (value) => context.read<DiscountsWatcherBloc>().add(
                      DiscountsWatcherEvent.filterCategory(
                        category: value,
                        isDesk: isDesk,
                      ),
                    ),
                isDesk: isDesk,
                itemKey: KWidgetkeys.screen.discounts.categoriesItems,
                isLoading: state.isLoading,
              ),
              textKey: KWidgetkeys.screen.discounts.categoriesText,
              title: context.l10n.category,
              value: state.firstActiveItem,
              onCancelWidgetPressed: (value) =>
                  context.read<DiscountsWatcherBloc>().add(
                        DiscountsWatcherEvent.filterCategory(
                          category: value,
                          isDesk: isDesk,
                        ),
                      ),
              isLoading: state.isLoading,
            );
          } else {
            return const SliverToBoxAdapter();
          }
        },
      ),
      BlocSelector<
          DiscountsWatcherBloc,
          DiscountsWatcherState,
          ({
            Map<String, FilterItem> locationMap,
            FilterItem? firstActiveItem,
            bool isLoading,
            bool locationIsNotEpmty,
            FilterStatus filterStatus,
          })>(
        selector: (state) => (
          locationMap: state.discountFilterRepository.locationMap,
          isLoading: state.filterStatus.isLoading,
          firstActiveItem:
              state.discountFilterRepository.activeLocationMap.first,
          locationIsNotEpmty: state.discountFilterRepository.locationIsNotEpmty,
          filterStatus: state.filterStatus,
        ),
        // buildWhen: (previous, current) =>
        //     previous.discountFilterRepository.locationMap !=
        //         current.discountFilterRepository.locationMap ||
        //     previous.filterStatus != current.filterStatus,
        builder: (context, state) {
          if (state.locationIsNotEpmty || state.isLoading) {
            return AdvancedFilterListWidget(
              isDesk: isDesk,
              list: SliverMainAxisGroup(
                slivers: [
                  if (!state.isLoading)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: KPadding.kPaddingSize16),
                        child: CitySearchFieldWidget(
                          isDesk: isDesk,
                        ),
                      ),
                    ),
                  _AdvancedListWidget(
                    filter: state.locationMap,
                    onChange: (value) =>
                        context.read<DiscountsWatcherBloc>().add(
                              DiscountsWatcherEvent.filterLocation(
                                location: value,
                                isDesk: isDesk,
                              ),
                            ),
                    isDesk: isDesk,
                    itemKey: KWidgetkeys.screen.discounts.cityItems,
                    isLoading: state.isLoading,
                  ),
                ],
              ),
              textKey: KWidgetkeys.screen.discounts.citiesText,
              title: context.l10n.city,
              value: state.firstActiveItem,
              onCancelWidgetPressed: (value) =>
                  context.read<DiscountsWatcherBloc>().add(
                        DiscountsWatcherEvent.filterLocation(
                          location: value,
                          isDesk: isDesk,
                        ),
                      ),
              isLoading: state.isLoading,
            );
          } else {
            return const SliverToBoxAdapter();
          }
        },
      ),
    ];
    return Padding(
      padding: isDesk
          ? const EdgeInsets.only(
              right: KPadding.kPaddingSize16,
              top: KPadding.kPaddingSize8,
            )
          : const EdgeInsets.symmetric(
              horizontal: KPadding.kPaddingSize16,
            ),
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
    required this.isLoading,
  });
  final Map<String, FilterItem> filter;
  final void Function(String) onChange;
  final bool isDesk;
  final Key itemKey;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _AdvancedLoadingListWidget(isDesk: isDesk, itemKey: itemKey);
    }
    return SliverPrototypeExtentList.builder(
      prototypeItem: Padding(
        padding: isDesk
            ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
            : const EdgeInsets.only(top: KPadding.kPaddingSize8),
        child: CheckPointAmountWidget(
          key: itemKey,
          isCheck: false,
          filterItem: KMockText.filterItem,
          isDesk: isDesk,
          onChanged: null,
          maxLines: 1,
        ),
      ),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: filter.length,
      findChildIndexCallback: (key) {
        if (key is ValueKey<String>) {
          final valueKey = key;
          if (filter.containsKey(valueKey.value)) {
            for (var i = 0; i < filter.keys.length; i++) {
              if (filter.keys.elementAt(i) == valueKey.value) {
                return i;
              }
            }
          }
        }
        return null;
      },
      itemBuilder: (context, index) {
        final value = filter[filter.keys.elementAt(index)]!;
        return CheckPointAmountWidget(
          key: ValueKey(filter.keys.elementAt(index)),
          widgetKey: itemKey,
          onChanged: () => onChange(
            value.value.uk,
          ),
          maxLines: 2,
          isCheck: value.isSelected,
          filterItem: value,
          isDesk: isDesk,
          amoutInactiveClor: isDesk ? null : AppColors.materialThemeWhite,
        );
      },
    );
  }
}

class _ChooseItems extends StatelessWidget {
  const _ChooseItems({
    required this.isDesk,
    required this.chosenItems,
    // required this.onChangeLocation,
    // required this.onChangeCategories,
    required this.categoriesLength,
    required this.eligibilitiesLength,
    // required this.onChangeEligibilities,
  });
  final bool isDesk;
  final Map<String, FilterItem> chosenItems;
  final int categoriesLength;
  final int eligibilitiesLength;
  // final void Function(String) onChangeLocation;
  // final void Function(String) onChangeCategories;
  // final void Function(String) onChangeEligibilities;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: isDesk
          ? const EdgeInsets.only(
              top: KPadding.kPaddingSize16,
              bottom: KPadding.kPaddingSize24,
            )
          : const EdgeInsets.only(
              top: KPadding.kPaddingSize8,
              bottom: KPadding.kPaddingSize8,
            ),
      sliver: SliverToBoxAdapter(
        child: Wrap(
          runSpacing: KPadding.kPaddingSize8,
          spacing: KPadding.kPaddingSize8,
          children: List.generate(
            chosenItems.length,
            (index) {
              final chooseItem =
                  chosenItems[chosenItems.keys.elementAt(index)]!;
              return CancelChipWidget(
                widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
                isDesk: isDesk,
                labelText: chooseItem.value.getTrsnslation(context),
                onPressed: () {
                  if (eligibilitiesLength > index) {
                    context.read<DiscountsWatcherBloc>().add(
                          DiscountsWatcherEvent.filterEligibilities(
                            eligibility: chooseItem.value.uk,
                            isDesk: isDesk,
                          ),
                        );
                  } else if (eligibilitiesLength + categoriesLength > index) {
                    context.read<DiscountsWatcherBloc>().add(
                          DiscountsWatcherEvent.filterCategory(
                            category: chooseItem.value.uk,
                            isDesk: isDesk,
                          ),
                        );
                  } else {
                    context.read<DiscountsWatcherBloc>().add(
                          DiscountsWatcherEvent.filterLocation(
                            location: chooseItem.value.uk,
                            isDesk: isDesk,
                          ),
                        );
                  }
                },
              );
            },
          ),
        ),
      ),
      // SliverPrototypeExtentList.builder(
      //   prototypeItem: Padding(
      //     padding: isDesk
      //         ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
      //         : const EdgeInsets.only(top: KPadding.kPaddingSize8),
      //     child: CancelChipWidget(
      //       widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
      //       isDesk: isDesk,
      //       labelText: KMockText.category.getTrsnslation(context),
      //       onPressed: null,
      //     ),
      //   ),
      //   itemCount: chosenItems.length,
      //   addAutomaticKeepAlives: false,
      //   addRepaintBoundaries: false,
      //   itemBuilder: (context, index) {
      //     final chooseItem = chosenItems[chosenItems.keys
      // .elementAt(index)]!;
      //     return Padding(
      //       padding: isDesk
      //           ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
      //           : const EdgeInsets.only(top: KPadding.kPaddingSize8),
      //       child: Align(
      //         alignment: Alignment.centerLeft,
      //         child: CancelChipWidget(
      //           widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
      //           isDesk: isDesk,
      //           labelText: chooseItem.value.getTrsnslation(context),
      //           onPressed: () {
      //             if (eligibilitiesLength > index) {
      //               context.read<DiscountsWatcherBloc>().add(
      //                     DiscountsWatcherEvent.filterEligibilities(
      //                       eligibility: chooseItem.value.uk,
      //                       isDesk: isDesk,
      //                     ),
      //                   );
      //             } else if (eligibilitiesLength + categoriesLength >
      // index) {
      //               context.read<DiscountsWatcherBloc>().add(
      //                     DiscountsWatcherEvent.filterCategory(
      //                       category: chooseItem.value.uk,
      //                       isDesk: isDesk,
      //                     ),
      //                   );
      //             } else {
      //               context.read<DiscountsWatcherBloc>().add(
      //                     DiscountsWatcherEvent.filterLocation(
      //                       location: chooseItem.value.uk,
      //                       isDesk: isDesk,
      //                     ),
      //                   );
      //             }
      //           },
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _AdvancedLoadingListWidget extends StatelessWidget {
  const _AdvancedLoadingListWidget({
    required this.isDesk,
    required this.itemKey,
  });
  final bool isDesk;
  final Key itemKey;

  @override
  Widget build(BuildContext context) {
    return SliverPrototypeExtentList.builder(
      prototypeItem: Padding(
        padding: isDesk
            ? const EdgeInsets.only(top: KPadding.kPaddingSize16)
            : const EdgeInsets.only(top: KPadding.kPaddingSize8),
        child: CheckPointAmountWidget(
          key: itemKey,
          isCheck: false,
          filterItem: KMockText.filterItem,
          isDesk: isDesk,
          maxLines: 1,
          onChanged: null,
        ),
      ),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: KDimensions.shimmerDiscountsFilterItems,
      itemBuilder: (context, index) {
        return Padding(
          padding: isDesk
              ? const EdgeInsets.only(top: KPadding.kPaddingSize24)
              : const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: SkeletonizerWidget(
            isLoading: true,
            highlightColor: isDesk
                ? AppColors.materialThemeWhite
                : AppColors.materialThemeKeyColorsNeutral,
            baseColor: isDesk
                ? AppColors.materialThemeKeyColorsNeutral
                : AppColors.materialThemeWhite,
            child: Skeleton.leaf(
              child: DecoratedBox(
                decoration: isDesk
                    ? KWidgetTheme.boxDecorationWidget
                    : KWidgetTheme.boxDecorationWhiteWidget,
                // child: CheckPointAmountWidget(
                //   key: itemKey,
                //   maxLines: 1,
                //   onChanged: null,
                //   isCheck: false,
                //   filterItem: KMockText.filterItem,
                //   isDesk: isDesk,
                //   amoutInactiveClor:
                //       isDesk ? null : AppColors.materialThemeWhite,
                // ),
              ),
            ),
          ),
        );
      },
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
