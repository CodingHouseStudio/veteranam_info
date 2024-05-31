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
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) {
            final childWidget = [
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
              DiscountFilters(
                key: KWidgetkeys.screen.discounts.filter,
                filtersItem: state.discountModelItems.overallTags,
                isDesk: isDesk,
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox56
              else
                KSizedBox.kHeightSizedBox24,
            ];
            switch (state.loadingStatus) {
              case LoadingStatus.initial:
                childWidget.add(const CircularProgressIndicator.adaptive());
              case LoadingStatus.loading:
                childWidget.add(const CircularProgressIndicator.adaptive());
              case LoadingStatus.loaded:
                if (state.discountModelItems.isNotEmpty) {
                  childWidget.addAll(
                    List.generate(state.filteredDiscountModelItems.length,
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
                    }),
                  );
                } else {
                  childWidget.add(
                    TextButton(
                      key: KWidgetkeys.screen.discounts.buttonMock,
                      onPressed: () {
                        GetIt.I
                            .get<IDiscountRepository>()
                            .addMockDiscountItems();
                        context
                            .read<DiscountWatcherBloc>()
                            .add(const DiscountWatcherEvent.started());
                      },
                      child: Text(
                        context.l10n.getMockData,
                        style: AppTextStyle.text32,
                      ),
                    ),
                  );
                }
              case LoadingStatus.error:
                childWidget.add(const CircularProgressIndicator.adaptive());
            }
            return childWidget
              ..addAll([
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
              ]);
          },
        );
      },
    );
  }
}
