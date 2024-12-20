import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
// import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsFilterMob extends StatelessWidget {
  const DiscountsFilterMob({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AdvancedFilterMobButton(
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

            // onPressed: () async {
            //   final bloc = context.read<DiscountsWatcherBloc>();
            //   await showModalBottomSheet<void>(
            //     context: context,
            //     isScrollControlled: true,
            //     barrierColor:
            //         AppColors.materialThemeKeyColorsSecondary.
            // withOpacity(0.2),
            //     backgroundColor: AppColors.materialThemeKeyColorsNeutral,
            //     shape: const RoundedRectangleBorder(
            //       borderRadius: BorderRadius.vertical(
            //         top: Radius.circular(KSize.kRadius32),
            //       ),
            //     ),
            //     showDragHandle: true,
            //     builder: (context) => AdvancedFilterMobBlocprovider(
            //       childWidget: const _AdvancedFilterMobDialog(),
            //       bloc: bloc,
            //     ),
            //   );
            // },

            // isDesk: false,
            ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: DiscountSortingWidget(isDesk: false),
          ),
        ),
      ],
    );
  }
}
