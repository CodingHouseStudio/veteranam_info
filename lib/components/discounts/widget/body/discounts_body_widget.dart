import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';
import 'package:skeletonizer/skeletonizer.dart';

part '../discounts_widget_list.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, _) {
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) => [
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox16,
            ...TitleWidget.titleWidgetList(
              title: context.l10n.discountsAndCoupons,
              titleKey: KWidgetkeys.screen.discounts.title,
              subtitle: context.l10n.discountsAndCouponsDescription,
              subtitleKey: KWidgetkeys.screen.discounts.title,
              isDesk: isDesk,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
            Row(
              children: [
                Expanded(
                  child: DiscountFilters(
                    key: KWidgetkeys.screen.discounts.filter,
                    filtersItem: _.discountModelItems.overallTags,
                    isDesk: isDesk,
                  ),
                ),
                TextButton(
                  // key: KWidgetkeys.screen.login.signUpButton,
                  onPressed: () =>
                      context.goNamedWithScroll(KRoute.myDiscounts.name),
                  style: KButtonStyles.whiteButtonStyle,
                  child: Text(context.l10n.offerDiscount),
                ),
              ],
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
            if (_.discountModelItems.isEmpty &&
                _.loadingStatus == LoadingStatus.loaded)
              Config.isDevelopment
                  ? MockButtonWidget(
                      key: KWidgetkeys.screen.discounts.buttonMock,
                      onPressed: () {
                        GetIt.I
                            .get<IDiscountRepository>()
                            .addMockDiscountItems();
                        context
                            .read<DiscountWatcherBloc>()
                            .add(const DiscountWatcherEvent.started());
                      },
                    )
                  : const SizedBox.shrink()
            else
              ...discountsWidgetList(context: context, isDesk: isDesk),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
            Center(
              child: LoadingButton(
                key: KWidgetkeys.screen.discounts.button,
                text: context.l10n.moreDiscounts,
                onPressed: () => context
                    .read<DiscountWatcherBloc>()
                    .add(const DiscountWatcherEvent.loadNextItems()),
                isDesk: isDesk,
                iconKey: KWidgetkeys.screen.discounts.buttonIcon,
              ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ],
        );
      },
    );
  }
}
