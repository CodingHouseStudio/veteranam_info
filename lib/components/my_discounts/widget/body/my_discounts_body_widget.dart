import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

part '../my_discounts_box_widget_list.dart';
part '../my_discounts_box_widgets.dart';

class MyDiscountsBodyWidget extends StatelessWidget {
  const MyDiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure?.value(context),
        onPressed: () => context
            .read<MyDiscountsWatcherBloc>()
            .add(const MyDiscountsWatcherEvent.started()),
      ),
      builder: (context, _) => ScaffoldWidget(
        titleChildWidgetsFunction: ({required isDesk}) => [
          KSizedBox.kHeightSizedBox24,
          Text(
            context.l10n.discountsAndCoupons,
            key: KWidgetkeys.screen.myDiscounts.title,
            style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
          ),
          KSizedBox.kHeightSizedBox8,
          Text(
            context.l10n.myDiscountsAndCoupons,
            key: KWidgetkeys.screen.myDiscounts.subtitle,
            style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox32,
          KSizedBox.kHeightSizedBox24,
        ],
        // mainDeskPadding: ({required maxWidth}) => const EdgeInsets.symmetric(
        //   horizontal: KPadding.kPaddingSize100,
        // ),
        mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.myPublications,
                style: isDesk ? AppTextStyle.text64 : AppTextStyle.text24,
              ),
              IconButtonWidget(
                key: KWidgetkeys.screen.myDiscounts.icon,
                padding:
                    isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize12,
                icon: KIcon.plus,
                background: AppColors.materialThemeKeyColorsNeutralVariant,
                onPressed: () => context.goNamed(KRoute.discountsAdd.name),
              ),
            ],
          ),
          ..._discountsboxWidgetList(
            context: context,
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox56
          else
            KSizedBox.kHeightSizedBox32,
        ],
      ),
    );
  }
}
