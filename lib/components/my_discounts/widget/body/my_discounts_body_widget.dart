import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/my_discounts/my_discounts.dart';
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
      builder: (context, _) => ScaffoldAutoLoadingWidget(
        // mainDeskPadding: ({required maxWidth}) => const EdgeInsets.symmetric(
        //   horizontal: KPadding.kPaddingSize100,
        // ),
        loadingButtonText: context.l10n.moreFunds,
        loadingStatus: _.loadingStatus,
        mainChildWidgetsFunction: ({required isDesk}) => [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.myPublications,
                key: KWidgetkeys.screen.myDiscounts.title,
                style: isDesk ? AppTextStyle.text64 : AppTextStyle.text24,
              ),
              IconButtonWidget(
                key: KWidgetkeys.screen.myDiscounts.iconAdd,
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
        loadFunction: () {
          context
              .read<MyDiscountsWatcherBloc>()
              .add(const MyDiscountsWatcherEvent.started());
        },
      ),
    );
  }
}
