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
        return ScaffoldWidget(
          mainChildWidgetsFunction: ({required isDesk}) => [
            KSizedBox.kHeightSizedBox24,
            ...TitleWidget.pointTitleWidgetList(
              title: context.l10n.specialOffers,
              titleKey: KWidgetkeys.screen.discounts.title,
              titleSecondPart: context.l10n.forVeteransAndTheirFamilies,
              pointText: context.l10n.discounts,
              pointKey: KWidgetkeys.screen.discounts.titlePoint,
              isDesk: isDesk,
              titleSecondPartPadding:
                  const EdgeInsets.only(left: KPadding.kPaddingSize72),
              iconCrossAxisAlignment: CrossAxisAlignment.end,
              isRightArrow: false,
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            FiltersChipWidget(
              key: KWidgetkeys.screen.discounts.filter,
              filtersItems: _.discountModelItems.overallTags(context),
              isDesk: isDesk,
              // onResetValue: () => context.read<DiscountWatcherBloc>().add(
              //       const DiscountWatcherEvent.filterReset(),
              //     ),
              isSelected: (index) =>
                  context
                      .read<DiscountWatcherBloc>()
                      .state
                      .filtersCategoriesIndex
                      ?.contains(index) ??
                  false,
              onSelected: (index) => context.read<DiscountWatcherBloc>().add(
                    DiscountWatcherEvent.filterCategory(
                      index,
                    ),
                  ),
            ),
            if (!isDesk) ...[
              KSizedBox.kHeightSizedBox24,
              AdvancedFilter(
                isDesk: isDesk,
                citiesList: context
                    .read<DiscountWatcherBloc>()
                    .state
                    .discountModelItems
                    .overallCities,
                filterCitiesIndex: const [],
              ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
            if (_.discountModelItems.isEmpty &&
                _.loadingStatus == LoadingStatus.loaded &&
                Config.isDevelopment)
              MockButtonWidget(
                key: KWidgetkeys.screen.discounts.buttonMock,
                onPressed: () {
                  GetIt.I.get<IDiscountRepository>().addMockDiscountItems();
                  context
                      .read<DiscountWatcherBloc>()
                      .add(const DiscountWatcherEvent.started());
                },
              )
            else
              ...discountsWidgetList(context: context, isDesk: isDesk),
            if (isDesk)
              KSizedBox.kHeightSizedBox56
            else
              KSizedBox.kHeightSizedBox24,
            LoadingButton(
              widgetKey: KWidgetkeys.screen.discounts.button,
              text: context.l10n.moreDiscounts,
              onPressed: () => context
                  .read<DiscountWatcherBloc>()
                  .add(const DiscountWatcherEvent.loadNextItems()),
              isDesk: isDesk,
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
