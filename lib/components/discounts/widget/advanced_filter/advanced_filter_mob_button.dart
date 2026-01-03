import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocSelector<DiscountsWatcherBloc, DiscountsWatcherState, bool>(
      // buildWhen: (previous, current) =>
      //     previous.filterStatus != current.filterStatus &&
      //     (current.discountFilterRepository.getActivityList.length == 1 ||
      //         current.discountFilterRepository.getActivityList.isEmpty),
      selector: (state) => state.discountFilterRepository.hasActivityItem,
      builder: (context, hasActivityItem) {
        if (hasActivityItem) {
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
        } else {
          return Align(
            alignment: Alignment.centerLeft, child: mobButton(context),

            // KSizedBox.kWidthSizedBox8,
          );
        }
      },
    );
    // }
  }

  Widget mobButton(BuildContext context) => TextButton.icon(
        key: DiscountsFilterKeys.mobButton,
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
          void showConfirmDialog() => context.dialog.showConfirmationDialog(
                isDesk: true,
                title: context.l10n.applySelectedFilter,
                subtitle: context.l10n.applySelectedFilterSubtitle,
                confirmText: context.l10n.yes,
                unconfirmText: context.l10n.no,
                onAppliedPressed: () =>
                    bloc.add(const DiscountsWatcherEvent.mobSetFilter()),
                confirmButtonBackground:
                    AppColors.materialThemeKeyColorsSecondary,
                onCancelPressed: () =>
                    bloc.add(const DiscountsWatcherEvent.mobRevertFilter()),
                onClosePressed: () =>
                    bloc.add(const DiscountsWatcherEvent.mobRevertFilter()),
              );
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
                    showConfirmDialog();
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
      key: DiscountsFilterKeys.dialog,
      heightFactor: KDimensions.bottomDialogHeightFactor,
      child: Column(
        children: [
          const Expanded(
            child: AdvancedFilterContent(
              isDesk: false,
            ),
          ),
          const Divider(
            color: AppColors.materialThemeBlackOpacity40,
            height: KSize.kPixel2,
          ),
          Padding(
            padding: const EdgeInsets.all(
              KPadding.kPaddingSize16,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                // spacing: KPadding.kPaddingSize8,
                verticalDirection: VerticalDirection.up,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: KPadding.kPaddingSize8,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(right: KPadding.kPaddingSize8),
                    child: BlocBuilder<DiscountsWatcherBloc,
                        DiscountsWatcherState>(
                      builder: (context, state) {
                        return AdvancedFilterResetButton(
                          isDesk: false,
                          resetEvent:
                              state.discountFilterRepository.hasActivityItem
                                  ? () => context.popDialog(value: false)
                                  : null,
                        );
                      },
                    ),
                  ),
                  DoubleButtonWidget(
                    text: context.l10n.apply,
                    hasAlign: false,
                    isDesk: false,
                    onPressed: () => context.popDialog(value: true),
                    widgetKey: DiscountsFilterKeys.mobAppliedButton,
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
