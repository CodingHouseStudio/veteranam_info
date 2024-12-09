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
            final bloc = context.read<DiscountWatcherBloc>();
            await showModalBottomSheet<void>(
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
                childWidget: const AdvancedFilterMobDialog(),
                bloc: bloc,
              ),
            );
          },

          isDesk: false,
        ),
        const DiscountSortingWidget(isDesk: false),
      ],
    );
  }
}

class AdvancedFilterMobDialog extends StatelessWidget {
  const AdvancedFilterMobDialog({super.key});

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
          KSizedBox.kHeightSizedBox8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KSizedBox.kWidthSizedBox8,
              BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
                builder: (context, state) {
                  return AdvancedFilterResetButton(
                    isDesk: false,
                    resetEvent: state.discountFilterRepository.hasActivityItem
                        ? () {
                            context.pop();
                            context
                                .read<DiscountWatcherBloc>()
                                .add(const DiscountWatcherEvent.filterReset());
                          }
                        : null,
                  );
                },
              ),
              KSizedBox.kWidthSizedBox8,
              DoubleButtonWidget(
                text: context.l10n.apply,
                isDesk: false,
                onPressed: () {
                  context.pop();
                  context
                      .read<DiscountWatcherBloc>()
                      .add(const DiscountWatcherEvent.setMobFilter());
                },
                widgetKey:
                    KWidgetkeys.screen.discounts.advancedFilterMobAppliedButton,
                darkMode: true,
              ),
              KSizedBox.kWidthSizedBox16,
            ],
          ),
          KSizedBox.kHeightSizedBox8,
        ],
      ),
    );
  }
}
