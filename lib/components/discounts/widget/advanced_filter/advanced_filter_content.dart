import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

abstract class AdvanceFilter {
  static Widget listView({
    required bool isDesk,
    required BuildContext context,
    required List<dynamic> filterLocationes,
    required List<DiscountEnum> sorting,
    required void Function(dynamic) onChange,
    required void Function(DiscountEnum) onChangeSorting,
  }) {
    final body = _widgetList(
      isDesk: isDesk,
      context: context,
      filterLocationes: filterLocationes,
      onChange: onChange,
      sorting: sorting,
      onChangeSorting: onChangeSorting,
    );
    return ListView.builder(
      key: KWidgetkeys.screen.discounts.advancedFilterList,
      padding: const EdgeInsets.all(KPadding.kPaddingSize16),
      itemBuilder: (context, index) => body.elementAt(index),
      itemCount: body.length,
      semanticChildCount: body.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
    );
  }

  static Widget resetButton({
    required bool isDesk,
    required BuildContext context,
    required void Function()? resetEvent,
  }) =>
      Padding(
        padding: isDesk
            ? EdgeInsets.zero
            : const EdgeInsets.only(left: KPadding.kPaddingSize16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            key: KWidgetkeys.screen.discounts.advancedFilterResetButton,
            style: KButtonStyles.borderBlackButtonStyle.copyWith(
              padding: isDesk
                  ? null
                  : const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize8,
                        horizontal: KPadding.kPaddingSize24,
                      ),
                    ),
            ),
            onPressed: resetEvent,
            child: Text(
              context.l10n.resetAll,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
        ),
      );

  static List<Widget> _widgetList({
    required bool isDesk,
    required BuildContext context,
    required List<dynamic> filterLocationes,
    required List<DiscountEnum> sorting,
    required void Function(dynamic) onChange,
    required void Function(DiscountEnum) onChangeSorting,
  }) {
    final locationes = context
        .read<DiscountWatcherBloc>()
        .state
        .categoryDiscountModelItems
        .getLocationFilter(context);
    return [
      // if (isDesk) KSizedBox.kHeightSizedBox32 else
      // KSizedBox.kHeightSizedBox24,
      if (filterLocationes.isNotEmpty || sorting.isNotEmpty) ...[
        if (isDesk)
          Row(
            children: [
              Expanded(
                child: Text(
                  context.l10n.filterApplied,
                  key: KWidgetkeys.screen.discounts.appliedFilterText,
                  style: AppTextStyle.materialThemeTitleLarge,
                ),
              ),
              resetButton(
                isDesk: true,
                context: context,
                resetEvent: () => context
                    .read<DiscountWatcherBloc>()
                    .add(const DiscountWatcherEvent.filterReset()),
              ),
            ],
          )
        else
          Text(
            context.l10n.filterApplied,
            key: KWidgetkeys.screen.discounts.appliedFilterText,
            style: AppTextStyle.materialThemeTitleMedium,
          ),
        ...List.generate(filterLocationes.length + sorting.length, (index) {
          final filter = sorting.length <= index
              ? filterLocationes.elementAt(index - sorting.length)
              : sorting.elementAt(index);
          return Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                key: KWidgetkeys.screen.discounts.appliedFilterItems,
                style: KButtonStyles.advancedFilterButtonStyle,
                icon: KIcon.close,
                label: Text(
                  filter is SubLocation
                      ? filter.getList(context).first
                      : filter is DiscountEnum
                          ? filter.getValue(context)
                          : locationes
                              .firstWhere(
                                (element) =>
                                    element.value == filter ||
                                    element.valueEN == filter,
                              )
                              .getString(context),
                  style: isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
                onPressed: () => filter is DiscountEnum
                    ? onChangeSorting(filter)
                    : onChange(
                        filter,
                      ),
              ),
            ),
          );
        }),
        KSizedBox.kHeightSizedBox24,
      ],
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
        locationes.length,
        (index) {
          final location = locationes.elementAt(index);
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
            ),
          );
        },
      ),
    ];
  }

  static Widget button({
    required bool isDesk,
    required void Function() onPressed,
    required BuildContext context,
    Icon? icon,
  }) =>
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton.icon(
          key: KWidgetkeys.screen.discounts.advancedFilterButton,
          style: KButtonStyles.advancedButtonStyle,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isDesk)
                Expanded(
                  child: Text(
                    context.l10n.advancedFilter,
                    style: isDesk
                        ? AppTextStyle.materialThemeHeadlineSmall
                        : AppTextStyle.materialThemeTitleMedium,
                  ),
                )
              else
                Text(
                  context.l10n.advancedFilter,
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineSmall
                      : AppTextStyle.materialThemeTitleMedium,
                ),
              if (icon != null) ...[KSizedBox.kWidthSizedBox8, icon],
            ],
          ),
          // KSizedBox.kWidthSizedBox8,
          icon: IconWidget(
            icon: KIcon.tune,
            background: AppColors.materialThemeKeyColorsNeutral,
            padding: isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
          ),
          onPressed: onPressed,
          //if (isDesk) KIcon.meil,
        ),
      );

  static bool _isCheck({
    required dynamic value,
    required List<dynamic>? filterLocationes,
  }) =>
      filterLocationes != null && filterLocationes.contains(value);
}
