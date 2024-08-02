import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

abstract class AdvanceFilter {
  static Widget listView({
    required bool isDesk,
    required BuildContext context,
    required List<int> filterLocationIndex,
    required void Function(int) onChange,
  }) {
    final body = _widgetList(
      isDesk: isDesk,
      context: context,
      filterLocationIndex: filterLocationIndex,
      onChange: onChange,
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
    required List<int> filterLocationIndex,
    required void Function(int) onChange,
  }) {
    final location = context
        .read<DiscountWatcherBloc>()
        .state
        .categoryDiscountModelItems
        .getLocationFilter(context);
    return [
      // if (isDesk) KSizedBox.kHeightSizedBox32 else
      // KSizedBox.kHeightSizedBox24,
      if (filterLocationIndex.isNotEmpty) ...[
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
        ...List.generate(
          filterLocationIndex.length,
          (index) => Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                key: KWidgetkeys.screen.discounts.appliedFilterItems,
                style: KButtonStyles.advancedFilterButtonStyle,
                icon: KIcon.close,
                label: Text(
                  location
                      .elementAt(filterLocationIndex.elementAt(index))
                      .value
                      .toString(),
                  style: isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
                onPressed: () => onChange(
                  filterLocationIndex.elementAt(index),
                ),
              ),
            ),
          ),
        ),
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
        2,
        (index) => Padding(
          padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
          child: CheckPointWidget(
            key: KWidgetkeys.screen.discounts.discountItems,
            onChanged: () => onChange(index),
            isCheck: _isCheck(
              index: index,
              filterLocationIndex: filterLocationIndex,
            ),
            text: location.elementAt(index).value.toString(),
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
        location.length - 2,
        (index) {
          final i = index + 2;
          return Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: CheckPointAmountWidget(
              key: KWidgetkeys.screen.discounts.cityItems,
              onChanged: () => onChange(i),
              isCheck:
                  _isCheck(index: i, filterLocationIndex: filterLocationIndex),
              filterItem: location.elementAt(i),
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
    required int index,
    required List<int>? filterLocationIndex,
  }) =>
      filterLocationIndex != null && filterLocationIndex.contains(index);
}
