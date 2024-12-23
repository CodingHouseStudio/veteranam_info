// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterMobButton extends StatelessWidget {
  const AdvancedFilterMobButton({
    // required this.isDesk,
    // this.onPressed,
    super.key,
  });
  // final bool isDesk;
  // final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    // if (isDesk) {
    //   return Align(
    //     alignment: Alignment.centerLeft,
    //     child: _buildAdvancedFilterRow(context, isDesk),

    //     // KSizedBox.kWidthSizedBox8,
    //   );
    // } else {
    return BlocBuilder<DiscountsWatcherBloc, DiscountsWatcherState>(
      buildWhen: (previous, current) =>
          previous.filterStatus != current.filterStatus &&
          (current.discountFilterRepository.getActivityList.length == 1 ||
              current.discountFilterRepository.getActivityList.isEmpty),
      builder: (context, state) {
        if (state.discountFilterRepository.getActivityList.isEmpty) {
          return Align(
            alignment: Alignment.centerLeft, child: mobButton(context),

            // KSizedBox.kWidthSizedBox8,
          );
        } else {
          return Stack(
            alignment: Alignment.topRight,
            children: [
              mobButton(context),
              const CircleAvatar(
                radius: KSize.kPixel6,
                backgroundColor: AppColors.materialThemeSourceSeed,
              ),
            ],
          );
        }
      },
    );
    // }
  }

  Widget mobButton(BuildContext context) => TextButton.icon(
        key: KWidgetkeys.screen.discounts.advancedFilterButton,
        style: KButtonStyles.advancedButtonStyle,
        label: Text(
          context.l10n.filter,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
        // KSizedBox.kWidthSizedBox8,
        icon: KIcon.tune,
        onPressed: () async {
          final bloc = context.read<DiscountsWatcherBloc>()
            ..add(
              const DiscountsWatcherEvent.mobSaveFilter(),
            );
          final configBloc = context.read<DiscountConfigCubit>();
          await showModalBottomSheet<bool>(
            context: context,
            isScrollControlled: true,
            barrierColor:
                AppColors.materialThemeKeyColorsSecondaryWithOpacity0_2,
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
              configBloc: configBloc,
            builder: (context) => Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.viewInsetsOf(context).bottom,
              ), // padding if mobile keyboard open
              child: AdvancedFilterMobBlocprovider(
                childWidget: const _AdvancedFilterMobDialog(),
                bloc: bloc,
              configBloc: configBloc,
              ),
            ),
          ).then(
            (value) async {
              switch (value) {
                case true:
                  bloc.add(const DiscountsWatcherEvent.mobSetFilter());
                case false:
                  bloc.add(const DiscountsWatcherEvent.filterReset());
                case null:
                  if (!bloc.state.discountFilterRepository.saveFilterEqual) {
                    // Wait close showModalBottomSheet dialog
                    // ignore: inference_failure_on_instance_creation
                    await Future.delayed(const Duration(milliseconds: 200));
                    context.dialog.showConfirmationDialog(
                      isDesk: true,
                      title: context.l10n.applySelectedFilter,
                      subtitle: context.l10n.applySelectedFilterSubtitle,
                      confirmText: context.l10n.yes,
                      unconfirmText: context.l10n.no,
                      onAppliedPressed: () =>
                          bloc.add(const DiscountsWatcherEvent.mobSetFilter()),
                      confirmButtonBackground:
                          AppColors.materialThemeKeyColorsSecondary,
                      onCancelPressed: () => bloc
                          .add(const DiscountsWatcherEvent.mobRevertFilter()),
                      onClosePressed: () => bloc
                          .add(const DiscountsWatcherEvent.mobRevertFilter()),
                    );
                  }
              }
            },
          );
        },
        //if (isDesk) KIcon.meil,
      );
  // Widget _buildAdvancedFilterRow(BuildContext context) {

  //       // if (isDesk)
  //       // return  Text(
  //       //     context.l10n.advancedFilter,
  //       //     style: isDesk
  //       //         ? AppTextStyle.materialThemeHeadlineSmall
  //       //         : AppTextStyle.materialThemeTitleMedium,
  //       //   )
  //       // else
  //      return   Text(
  //           context.l10n.advancedFilter,
  //           style: AppTextStyle.materialThemeTitleMedium,
  //   );
  // }
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
