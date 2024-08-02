import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

class AdvancedFilterMob extends StatelessWidget {
  const AdvancedFilterMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdvanceFilter.button(
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
          builder: (context) => AdvancedFilterMobBlocprovider(
            childWidget: const AdvancedFilterMobDialog(),
            bloc: bloc,
          ),
        );
      },

      isDesk: false,
      context: context,
    );
  }
}

class AdvancedFilterMobDialog extends StatelessWidget {
  const AdvancedFilterMobDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvancedFilterMobCubit, List<int>>(
      builder: (context, _) {
        return FractionallySizedBox(
          key: KWidgetkeys.screen.discounts.advancedFilterDialog,
          heightFactor: 0.9,
          child: Column(
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
              // KSizedBox.kHeightSizedBox16,
              // Text(
              //   context.l10n.advancedFilter,
              //   key: KWidgetkeys.screen.discounts.cancelText,
              //   style: AppTextStyle.materialThemeTitleMedium,
              // ),
              //   ],
              // ),
              Expanded(
                child: AdvanceFilter.listView(
                  isDesk: false,
                  context: context,
                  onChange: (index) => context
                      .read<AdvancedFilterMobCubit>()
                      .changeFilterList(index),
                  filterLocationIndex: _,
                ),
              ),
              KSizedBox.kHeightSizedBox8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AdvanceFilter.resetButton(
                    isDesk: false,
                    context: context,
                    resetEvent: _.isNotEmpty
                        ? () => context.read<AdvancedFilterMobCubit>().reset()
                        : null,
                  ),
                  KSizedBox.kWidthSizedBox8,
                  DoubleButtonWidget(
                    text: context.l10n.apply,
                    isDesk: false,
                    onPressed: () {
                      context
                          .read<DiscountWatcherBloc>()
                          .add(DiscountWatcherEvent.filterLocations(_));
                      context.pop();
                    },
                    widgetKey: KWidgetkeys
                        .screen.discounts.advancedFilterMobAppliedButton,
                    color: AppColors.materialThemeKeyColorsSecondary,
                    textColor: AppColors.materialThemeWhite,
                  ),
                ],
              ),
              KSizedBox.kHeightSizedBox8,
            ],
          ),
        );
      },
    );
  }
}
