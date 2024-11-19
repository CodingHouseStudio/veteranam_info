import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterMob extends StatelessWidget {
  const AdvancedFilterMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AdvancedFilterButton(
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

      onPressed: () {
        final bloc = context.read<DiscountWatcherBloc>();
        showModalBottomSheet<AdvancedFilterMobState>(
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
            initialFilter: bloc.state.filterLocation,
            initialSorting: bloc.state.sorting,
            initChooseLocationList: bloc.state.choosenLocationList,
            initialChooseSorting: bloc.state.choosenSortingnList,
          ),
        ).then(
          (_) {
            if (!context.mounted) return;

            if (_ != null) {
              context.read<DiscountWatcherBloc>().add(
                    DiscountWatcherEvent.setMobFilter(
                      filterList: _.filtersLocation,
                      sorting: _.sorting,
                      choosenLocationList: _.choosenLocationList,
                      choosenSortingnList: _.choosenSortingnList,
                    ),
                  );
            } else {
              context.read<DiscountWatcherBloc>().add(
                    const DiscountWatcherEvent.filterReset(),
                  );
            }
          },
        );
      },

      isDesk: false,
    );
  }
}

class AdvancedFilterMobDialog extends StatelessWidget {
  const AdvancedFilterMobDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvancedFilterMobCubit, AdvancedFilterMobState>(
      builder: (context, _) {
        return FractionallySizedBox(
          key: KWidgetkeys.screen.discounts.advancedFilterDialog,
          heightFactor: KDimensions.bottomDialogHeightFactor,
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
                child: AdvancedFilterContent(
                  isDesk: false,
                  onChange: (value) => context
                      .read<AdvancedFilterMobCubit>()
                      .changeFilterList(value),
                  filterLocationes: _.filtersLocation,
                  sorting: _.sorting,
                  onChangeSorting: (value) =>
                      context.read<AdvancedFilterMobCubit>().sorting(value),
                  chooseLocationList: _.choosenLocationList,
                  chooseSortingList: _.choosenSortingnList,
                ),
              ),
              KSizedBox.kHeightSizedBox8,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  KSizedBox.kWidthSizedBox8,
                  AdvancedFilterResetButton(
                    isDesk: false,
                    resetEvent: _.choosenLocationList.isNotEmpty ||
                            _.choosenSortingnList.isNotEmpty
                        ? context.pop
                        : null,
                  ),
                  KSizedBox.kWidthSizedBox8,
                  DoubleButtonWidget(
                    text: context.l10n.apply,
                    isDesk: false,
                    onPressed: () {
                      context.pop(_);
                    },
                    widgetKey: KWidgetkeys
                        .screen.discounts.advancedFilterMobAppliedButton,
                    darkMode: true,
                  ),
                  KSizedBox.kWidthSizedBox16,
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
