import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsFilterMob extends StatelessWidget {
  const DiscountsFilterMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdvancedFilterButton(
          //   key: KWidgetkeys.screen.discounts.advancedFilterButton,
          //   style: KButtonStyles.advancedButtonStyle,
          //   label: Text(
          //     context.l10n.advancedFilter,
          //     style: AppTextStyle.materialThemeTitleMedium,
          //   ),
          // KSizedBox.kWidthSizedBox8,
          // icon: const IconWidget(
          //   icon: KIcon.tune,
          //   background: AppColors.materialThemeKeyColorsNeutral,
          //   padding: KPadding.kPaddingSize12,
          // ),

          onPressed: () async {
            final bloc = context.read<DiscountsWatcherBloc>()
              ..add(
                const DiscountsWatcherEvent.mobSaveFilter(),
              );
            log('TEFDSFDSF START ${DateTime.now()}');
            bloc.add(const DiscountsWatcherEvent.mobRevertFilter());
            log('TEFDSFDSF END ${DateTime.now()}');
            await showModalBottomSheet<bool>(
              context: context,
              isScrollControlled: true,
              barrierColor:
                  AppColors.materialThemeKeyColorsSecondary.withOpacity(0.2),
              backgroundColor: AppColors.materialThemeKeyColorsNeutral,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(KSize.kRadius32),
                ),
              ),
              showDragHandle: true,
              builder: (context) => AdvancedFilterMobBlocprovider(
                childWidget: const _AdvancedFilterMobDialog(),
                bloc: bloc,
              ),
            ).then(
              (value) {
                log('TEFDSFDSF START ${DateTime.now()}');
                switch (value) {
                  case true:
                    bloc.add(const DiscountsWatcherEvent.mobSetFilter());
                  case false:
                    bloc.add(const DiscountsWatcherEvent.filterReset());
                  case null:
                    bloc.add(const DiscountsWatcherEvent.mobRevertFilter());
                }
                log('TEFDSFDSF END ${DateTime.now()}');
              },
            );
          },

          isDesk: false,
        ),
        const DiscountSortingWidget(isDesk: false),
      ],
    );
  }
}

class _AdvancedFilterMobDialog extends StatelessWidget {
  const _AdvancedFilterMobDialog();

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      key: KWidgetkeys.screen.discounts.advancedFilterDialog,
      heightFactor: KDimensions.bottomDialogHeightFactor,
      child: Column(
        children: [
          const Expanded(
            child: AdvancedFilterContent(
              isDesk: false,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: KPadding.kPaddingSize16,
              ),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: KPadding.kPaddingSize8,
                verticalDirection: VerticalDirection.up,
                runSpacing: KPadding.kPaddingSize8,
                children: [
                  BlocBuilder<DiscountsWatcherBloc, DiscountsWatcherState>(
                    builder: (context, state) {
                      return AdvancedFilterResetButton(
                        isDesk: false,
                        resetEvent:
                            state.discountFilterRepository.hasActivityItem
                                ? () => context.pop(false)
                                : null,
                      );
                    },
                  ),
                  DoubleButtonWidget(
                    text: context.l10n.apply,
                    hasAlign: false,
                    isDesk: false,
                    onPressed: () => context.pop(true),
                    widgetKey: KWidgetkeys
                        .screen.discounts.advancedFilterMobAppliedButton,
                    darkMode: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
