import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../discounts_widget_list.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscountWatcherBloc, DiscountWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure!.value(context),
        onPressed: () => context
            .read<DiscountWatcherBloc>()
            .add(const DiscountWatcherEvent.started()),
      ),
      listenWhen: (previous, current) => current.failure != null,
      builder: (context, _) {
        return ScaffoldAutoLoadingWidget(
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
            if (isDesk)
              Row(
                children: [
                  Expanded(
                    child: _filter(
                      context: context,
                      isDesk: isDesk,
                    ),
                  ),
                  _myDiscountButton(context),
                ],
              )
            else ...[
              _filter(
                context: context,
                isDesk: isDesk,
              ),
              KSizedBox.kHeightSizedBox8,
              _myDiscountButton(context),
            ],
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
            // LoadingButton(
            //   widgetKey: KWidgetkeys.screen.discounts.button,
            //   text: context.l10n.moreDiscounts,
            //   onPressed: () => context
            //       .read<DiscountWatcherBloc>()
            //       .add(const DiscountWatcherEvent.loadNextItems()),
            //   isDesk: isDesk,
            // ),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
          ],
          scrollFunction: () => context
              .read<DiscountWatcherBloc>()
              .add(const DiscountWatcherEvent.loadNextItems()),
        );
      },
    );
  }

  Widget _filter({
    required BuildContext context,
    required bool isDesk,
  }) =>
      FiltersChipWidget(
        key: KWidgetkeys.screen.discounts.filter,
        filtersItems: context
            .read<DiscountWatcherBloc>()
            .state
            .discountModelItems
            .overallTags(context),
        isDesk: isDesk,
        onResetValue: () => context.read<DiscountWatcherBloc>().add(
              const DiscountWatcherEvent.filterReset(),
            ),
        isSelected: (index) =>
            context
                .read<DiscountWatcherBloc>()
                .state
                .filtersIndex
                ?.contains(index) ??
            false,
        onSelected: (index) => context.read<DiscountWatcherBloc>().add(
              DiscountWatcherEvent.filter(
                index,
              ),
            ),
      );

  Widget _myDiscountButton(
    BuildContext context,
  ) =>
      TextButton(
        key: KWidgetkeys.screen.discounts.addDiscountButton,
        onPressed: () => context.goNamedWithScroll(KRoute.myDiscounts.name),
        style: KButtonStyles.whiteButtonStyle,
        child: Text(context.l10n.offerDiscount),
      );
}
