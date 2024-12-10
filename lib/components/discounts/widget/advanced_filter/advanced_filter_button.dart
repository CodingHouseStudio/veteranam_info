import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class AdvancedFilterButton extends StatelessWidget {
  const AdvancedFilterButton({
    required this.isDesk,
    this.onPressed,
    super.key,
  });
  final bool isDesk;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Align(
        alignment: Alignment.centerLeft,
        child: _buildAdvancedFilterRow(context, isDesk),

        // KSizedBox.kWidthSizedBox8,
      );
    } else {
      return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
        buildWhen: (previous, current) =>
            previous.filterStatus != current.filterStatus &&
            current.discountFilterRepository.getActivityList.isEmpty !=
                previous.discountFilterRepository.getActivityList.isEmpty,
        builder: (context, state) {
          if (state.discountFilterRepository.getActivityList.isEmpty) {
            return Align(
              alignment: Alignment.centerLeft, child: mobButton,

              // KSizedBox.kWidthSizedBox8,
            );
          } else {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                mobButton,
                const CircleAvatar(
                  radius: KSize.kPixel6,
                  backgroundColor: AppColors.materialThemeSourceSeed,
                ),
              ],
            );
          }
        },
      );
    }
  }

  Widget get mobButton => IconButton(
        key: KWidgetkeys.screen.discounts.advancedFilterButton,
        style: KButtonStyles.advancedButtonStyle,
        // label: _buildAdvancedFilterRow(context, isDesk),
        // KSizedBox.kWidthSizedBox8,
        icon: const IconWidget(
          icon: KIcon.tune,
          background: AppColors.materialThemeKeyColorsNeutral,
          padding: KPadding.kPaddingSize12,
        ),
        onPressed: onPressed,
        //if (isDesk) KIcon.meil,
      );
  Widget _buildAdvancedFilterRow(BuildContext context, bool isDesk) {
    return Row(
      key: isDesk ? KWidgetkeys.screen.discounts.advancedFilterButton : null,
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
      ],
    );
  }
}
