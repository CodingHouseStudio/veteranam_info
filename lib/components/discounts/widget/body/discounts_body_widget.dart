import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
        switch (state.loadingStatus) {
          case LoadingStatus.initial:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loading:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.error:
            return const CircularProgressIndicator.adaptive();
          case LoadingStatus.loaded:
            return ScaffoldWidget(
              mainChildWidgetsFunction: ({required isDesk}) => [
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox16,
                Text(
                  context.l10n.discountsAndCoupons,
                  style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
                ),
                KSizedBox.kHeightSizedBox8,
                Text(
                  context.l10n.discountsAndCouponsDescription,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                DiscountFilters(
                  key: KWidgetkeys.screen.discounts.filter,
                  filtersItem: state.discountModelItems.overallTags,
                  isDesk: isDesk,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox40
                else
                  KSizedBox.kHeightSizedBox24,
                if (state.discountModelItems.isNotEmpty)
                  ...List.generate(state.filteredDiscountModelItems.length,
                      (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: index != 0 ? KPadding.kPaddingSize40 : 0,
                      ),
                      child: DiscountsCardWidget(
                        key: KWidgetkeys.screen.discounts.card,
                        discountItem:
                            state.filteredDiscountModelItems.elementAt(index),
                        isDesk: isDesk,
                      ),
                    );
                  })
                else
                  TextButton(
                    key: KWidgetkeys.screen.discounts.buttonMock,
                    onPressed: () {
                      GetIt.I.get<IDiscountRepository>().addMockDiscountItems();
                      context
                          .read<DiscountWatcherBloc>()
                          .add(const DiscountWatcherEvent.started());
                    },
                    child: Text(
                      context.l10n.getMockData,
                      style: AppTextStyle.text32,
                    ),
                  ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
                Center(
                  child: ButtonWidget(
                    key: KWidgetkeys.screen.discounts.button,
                    text: context.l10n.moreDiscounts,
                    onPressed: () => context
                        .read<DiscountWatcherBloc>()
                        .add(const DiscountWatcherEvent.loadNextItems()),
                    icon: isDesk
                        ? KIcon.refresh.setIconKey(
                            KWidgetkeys.screen.discounts.buttonIcon,
                          )
                        : null,
                    isDesk: isDesk,
                  ),
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox56
                else
                  KSizedBox.kHeightSizedBox24,
              ],
            );
        }
      },
    );
  }
}
