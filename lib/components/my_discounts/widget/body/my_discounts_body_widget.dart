import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:kozak/shared/widget/statistic_box_widget.dart';

part '../my_discounts_box_widget_list.dart';

class MyDiscountsBodyWidget extends StatelessWidget {
  const MyDiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyDiscountsWatcherBloc, MyDiscountsWatcherState>(
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
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isDesk ? KPadding.kPaddingSize100 : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.myPublications,
                  style: isDesk ? AppTextStyle.text64 : AppTextStyle.text24,
                ),
                IconWidget(
                  padding: isDesk
                      ? KPadding.kPaddingSize20
                      : KPadding.kPaddingSize12,
                  icon: KIcon.plus,
                  background: AppColors.materialThemeKeyColorsNeutralVariant,
                ),
              ],
            ),
          ),
          KSizedBox.kHeightSizedBox24,
        ],
        mainDeskPadding: const EdgeInsets.symmetric(
          horizontal: KPadding.kPaddingSize100,
        ),
        mainChildWidgetsFunction: ({required isDesk}) => [
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

//mainChildWidgetsFunction: ({required isDesk}) {
    // final childWidgets = <Widget>[];
    // switch (_) {
    //   case MyDiscountsWatcherStateInitial():
    //     childWidgets.add(const CircularProgressIndicator.adaptive());
    //   case MyDiscountsWatcherStateLoading():
    //     childWidgets.add(const CircularProgressIndicator.adaptive());
    //   case MyDiscountsWatcherStateSuccess():
    //     if (_.discountsModelItems.isNotEmpty) {
    //       childWidgets.addAll(

    //         List.generate(_.discountsModelItems.length, (index) {
    //           return Padding(
    //             padding: index != 0
    //                 ? EdgeInsets.only(
    //                     top: isDesk
    //                         ? KPadding.kPaddingSize56
    //                         : KPadding.kPaddingSize24,
    //                   )
    //                 : EdgeInsets.zero,
    //             //тут викликати бокс віджет
    //             child: MyDiscountsBoxWidget(
    //               isDesk: isDesk,
    //               discountItems: _.discountsModelItems,
    //             ),
    //             // child: DiscountsCardWidget(
    //             //   key: KWidgetkeys.screen.myDiscounts.card,
    //             //   discountItem: _.discountsModelItems.elementAt(index),
    //             //   isDesk: isDesk,
    //             // ),
    //           );
    //         }),
    //       );
    //     }

    //   case MyDiscountsWatcherStateFailure():
    //     childWidgets.add(const CircularProgressIndicator.adaptive());
    // }
    // return childWidgets
    //   ..add(
    //     isDesk
    //         ? KSizedBox.kHeightSizedBox56
    //         : KSizedBox.kHeightSizedBox24,
    //   );
    // },

    // ScaffoldWidget(
    //   mainChildWidgetsFunction: ({required isDesk}) => [
    //     ...TitleWidget.titleWidgetList(
    //       title: context.l10n.discountsAndCoupons,
    //       titleKey: KWidgetkeys.screen.myDiscounts.title,
    //       subtitle: context.l10n.myDiscountsAndCoupons,
    //       subtitleKey: KWidgetkeys.screen.myDiscounts.subtitle,
    //       isDesk: isDesk,
    //     ),
    //     if (isDesk)
    //       KSizedBox.kHeightSizedBox56
    //     else
    //       KSizedBox.kHeightSizedBox32,
    //     Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text(
    //               context.l10n.myPublications,
    //               style: isDesk ? AppTextStyle.text64 : AppTextStyle.text24,
    //             ),
    //             const IconWidget(
    //               padding: KPadding.kPaddingSize20,
    //               icon: KIcon.plus,
    //               background: AppColors.materialThemeKeyColorsNeutralVariant,
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ],
    // );
  }
}
