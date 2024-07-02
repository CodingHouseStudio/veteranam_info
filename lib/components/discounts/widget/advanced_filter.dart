import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class AdvancedFilterMob extends StatelessWidget {
  const AdvancedFilterMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _AdvanceFilter.button(
      onPressed: () async {
        final bloc = context.read<DiscountWatcherBloc>();
        await showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          barrierColor:
              AppColors.materialThemeKeyColorsSecondary.withOpacity(0.2),
          backgroundColor: AppColors.materialThemeKeyColorsNeutral,
          shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(KSize.kRadius32)),
          ),
          showDragHandle: true,
          builder: (context) => FractionallySizedBox(
            heightFactor: 0.9,
            child: BlocProvider.value(
              value: bloc,
              child: BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
                builder: (context, state) => Column(
                  children: [
                    // Row(
                    //   children: [
                    //     IconButtonWidget(
                    //       key: KWidgetkeys.screen.discounts.cancelIcon,
                    //       icon: KIcon.close,
                    //       background: AppColors.materialThemeWhite,
                    //       padding: KPadding.kPaddingSize12,
                    //       onPressed: () => context.pop(),
                    //     ),
                    KSizedBox.kHeightSizedBox16,
                    Text(
                      context.l10n.advancedFilter,
                      key: KWidgetkeys.screen.discounts.cancelText,
                      style: AppTextStyle.materialThemeTitleMedium,
                    ),
                    //   ],
                    // ),
                    Expanded(
                      child: _AdvanceFilter.listView(
                        isDesk: false,
                        context: context,
                      ),
                    ),
                    ..._AdvanceFilter.resetButton(
                      isDesk: false,
                      context: context,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      isDesk: false,
      context: context,
    );
  }
}

class AdvancedFilterDesk extends StatefulWidget {
  const AdvancedFilterDesk({super.key});

  @override
  State<AdvancedFilterDesk> createState() => _AdvancedFilterDeskState();
}

class _AdvancedFilterDeskState extends State<AdvancedFilterDesk> {
  late bool bodyHiden;

  @override
  void initState() {
    bodyHiden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: KPadding.kPaddingSize32),
          child: Column(
            children: [
              _AdvanceFilter.button(
                onPressed: () => setState(() {
                  bodyHiden = !bodyHiden;
                }),
                isDesk: true,
                context: context,
                icon: bodyHiden
                    ? KIcon.trailing.copyWith(
                        key: KWidgetkeys
                            .screen.discounts.advancedFilterButtonIcon,
                      )
                    : KIcon.trailingUp.copyWith(
                        key: KWidgetkeys
                            .screen.discounts.advancedFilterButtonIconUp,
                      ),
              ),
              if (!bodyHiden) ...[
                Expanded(
                  child:
                      _AdvanceFilter.listView(isDesk: true, context: context),
                ),
                ..._AdvanceFilter.resetButton(isDesk: true, context: context),
              ],
            ],
          ),
        );
      },
    );
  }
}

abstract class _AdvanceFilter {
  static Widget listView({
    required bool isDesk,
    required BuildContext context,
  }) {
    final body = _widgetList(
      isDesk: isDesk,
      context: context,
    );
    return ListView.builder(
      key: KWidgetkeys.screen.discounts.advancedFilterList,
      padding: isDesk
          ? EdgeInsets.zero
          : const EdgeInsets.all(KPadding.kPaddingSize16),
      itemBuilder: (context, index) => body.elementAt(index),
      itemCount: body.length,
      semanticChildCount: body.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
    );
  }

  static List<Widget> resetButton({
    required bool isDesk,
    required BuildContext context,
  }) =>
      [
        KSizedBox.kHeightSizedBox24,
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            key: KWidgetkeys.screen.discounts.advancedFilterResetButton,
            style: KButtonStyles.borderBlackButtonStyle,
            onPressed: () => context
                .read<DiscountWatcherBloc>()
                .add(const DiscountWatcherEvent.filterReset()),
            child: Text(
              context.l10n.resetAll,
              style: isDesk
                  ? AppTextStyle.materialThemeTitleLarge
                  : AppTextStyle.materialThemeTitleMedium,
            ),
          ),
        ),
        KSizedBox.kHeightSizedBox16,
      ];

  static List<Widget> _widgetList({
    required bool isDesk,
    required BuildContext context,
  }) {
    final filterLocationIndex =
        context.read<DiscountWatcherBloc>().state.filtersLocationIndex;
    final location = context
        .read<DiscountWatcherBloc>()
        .state
        .discountModelItems
        .getLocationFilter(context);
    return [
      if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox24,
      Text(
        context.l10n.filterApplied,
        key: KWidgetkeys.screen.discounts.appliedFilterText,
        style: isDesk
            ? AppTextStyle.materialThemeTitleLarge
            : AppTextStyle.materialThemeTitleMedium,
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
                location.elementAt(filterLocationIndex.elementAt(index)).value,
                style: isDesk
                    ? AppTextStyle.materialThemeBodyLarge
                    : AppTextStyle.materialThemeBodyMedium,
              ),
              onPressed: () => _onChange(
                context: context,
                index: filterLocationIndex.elementAt(index),
              ),
            ),
          ),
        ),
      ),
      KSizedBox.kHeightSizedBox24,
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
            onChanged: () => _onChange(context: context, index: index),
            isCheck: _isCheck(
              index: index,
              filterLocationIndex: filterLocationIndex,
            ),
            text: location.elementAt(index).value,
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
              onChanged: () => _onChange(context: context, index: i),
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

  static void _onChange({required int index, required BuildContext context}) =>
      context
          .read<DiscountWatcherBloc>()
          .add(DiscountWatcherEvent.filterLocation(index));
}
