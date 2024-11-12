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
  final List<FilterItem> sorting;
  final List<FilterItem> chooseSortingList;
  final void Function(dynamic) onChange;
  final void Function(DiscountEnum) onChangeSorting;

  @override
  Widget build(BuildContext context) {
    final body = [
      // if (isDesk) KSizedBox.kHeightSizedBox32 else
      // KSizedBox.kHeightSizedBox24,
      // if (chooseLocationList.isNotEmpty || sorting.isNotEmpty) ...[
      //   if (isDesk)
      //     Row(
      //       children: [
      //         Expanded(
      //           child: Text(
      //             context.l10n.filterApplied,
      //             key: KWidgetkeys.screen.discounts.appliedFilterText,
      //             style: AppTextStyle.materialThemeTitleLarge,
      //           ),
      //         ),
      //         AdvancedFilterResetButton(
      //           isDesk: true,
      //           resetEvent: () => context
      //               .read<DiscountWatcherBloc>()
      //               .add(const DiscountWatcherEvent.filterReset()),
      //         ),
      //       ],
      //     )
      //   else
      //     Text(
      //       context.l10n.filterApplied,
      //       key: KWidgetkeys.screen.discounts.appliedFilterText,
      //       style: AppTextStyle.materialThemeTitleMedium,
      //     ),
      //   ...List.generate(filterLocationes.length + sorting.length, (index) {
      //     final filter = sorting.length <= index
      //         ? chooseLocationList.elementAt(index - sorting.length)
      //         : sorting.elementAt(index);
      //     return Padding(
      //       padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
      //       child: Align(
      //         alignment: Alignment.centerLeft,
      //         child: CancelChipWidget(
      //           widgetKey: KWidgetkeys.screen.discounts.appliedFilterItems,
      //           isDesk: isDesk,
      //           labelText: filter is SubLocation
      //               ? filter.getList(context).first
      //               : filter is DiscountEnum
      //                   ? filter.getValue(context)
      //                   : (filter as FilterItem).getString(context),
      //           onPressed: () {
      //             if (filter is DiscountEnum) {
      //               onChangeSorting(filter);
      //             } else {
      //               onChange(
      //                 filter,
      //               );
      //             }
      //           },
      //         ),
      //       ),
      //     );
      //   }),
      //   KSizedBox.kHeightSizedBox24,
      // ],
      Text(
        context.l10n.discount,
        key: KWidgetkeys.screen.discounts.discountText,
        style: isDesk
            ? AppTextStyle.materialThemeTitleLarge
            : AppTextStyle.materialThemeTitleMedium,
      ),
      ...List.generate(
        DiscountEnum.values.length,
        (index) => Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: CheckPointWidget(
            key: KWidgetkeys.screen.discounts.discountItems,
            onChanged: () =>
                onChangeSorting(DiscountEnum.values.elementAt(index)),
            isCheck: _isCheck(
              value: DiscountEnum.values.elementAt(index),
              filterLocationes: sorting,
            ),
            text: DiscountEnum.values.elementAt(index).getValue(context),
            isDesk: isDesk,
          ),
        ),
      ),
      KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.city,
        key: KWidgetkeys.screen.discounts.cityText,
        style: isDesk
            ? AppTextStyle.materialThemeTitleLarge
            : AppTextStyle.materialThemeTitleMedium,
      ),
      ...List.generate(
        filterLocationes.length,
        (index) {
          final location = filterLocationes.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: CheckPointAmountWidget(
              key: KWidgetkeys.screen.discounts.cityItems,
              onChanged: () => onChange(
                location.value.toString().getSublocation(context) ??
                    location.value,
              ),
              isCheck: _isCheck(
                value: location.value.toString().getSublocation(context) ??
                    location.value,
                filterLocationes: filterLocationes,
              ),
              filterItem: location,
              isDesk: isDesk,
              amoutInactiveClor: isDesk ? null : AppColors.materialThemeWhite,
            ),
          );
        },
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
      addRepaintBoundaries: false,
      shrinkWrap: isDesk,
    );
  }

  static bool _isCheck({
    required dynamic value,
    required List<dynamic>? filterLocationes,
  }) =>
      filterLocationes != null && filterLocationes.contains(value);
}
