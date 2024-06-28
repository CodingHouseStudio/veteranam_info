import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/components/components.dart';
import 'package:kozak/shared/shared.dart';

part '../discounts_widget_list.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    late var listCanLoaded = true;
    return BlocConsumer<DiscountWatcherBloc, DiscountWatcherState>(
      listener: (context, state) => context.dialog.showGetErrorDialog(
        error: state.failure!.value(context),
        onPressed: () => context
            .read<DiscountWatcherBloc>()
            .add(const DiscountWatcherEvent.started()),
      ),
      listenWhen: (previous, current) {
        listCanLoaded = previous.filteredDiscountModelItems.length !=
            current.filteredDiscountModelItems.length;
        return current.failure != null;
      },
      builder: (context, _) {
        return ScaffoldAutoLoadingWidget(
          loadingButtonText: context.l10n.moreDiscounts,
          listCanLoaded: _.discountModelItems.length >
                  _.filteredDiscountModelItems.length ||
              listCanLoaded,
          titleChildWidgetsFunction: ({required isDesk}) => [
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
            if (isDesk)
              Row(
                children: [
                  Expanded(
                    child: _filter(
                      context: context,
                      isDesk: isDesk,
                    ),
                  ),
                  if (Config.isDevelopment) _myDiscountButton(context),
                ],
              )
            else ...[
              _filter(
                context: context,
                isDesk: isDesk,
              ),
              if (Config.isDevelopment) ...[
                KSizedBox.kHeightSizedBox8,
                _myDiscountButton(context),
              ],
              KSizedBox.kHeightSizedBox24,
              AdvancedFilterMob(
                key: KWidgetkeys.screen.discounts.advancedFilter,
              ),
            ],
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
          ],
          mainRightChildWidget: AdvancedFilterDesk(
            key: KWidgetkeys.screen.discounts.advancedFilter,
          ),
          mainChildWidgetsFunction: ({required isDesk}) => [
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
            .overallItems(
              context: context,
              getFilter: (item) => item.category,
              getUAFilter: (item) => item.categoryUA,
            ),
        isDesk: isDesk,
        // onResetValue: () => context.read<DiscountWatcherBloc>().add(
        //       const DiscountWatcherEvent.filterReset(),
        //     ),
        isSelected: (index) => context
            .read<DiscountWatcherBloc>()
            .state
            .filtersCategoriesIndex
            .contains(index),
        onSelected: (index) => context.read<DiscountWatcherBloc>().add(
              DiscountWatcherEvent.filterCategory(
                index,
              ),
            ),
        fullLenght:
            context.read<DiscountWatcherBloc>().state.discountModelItems.length,
        filterIsEmpty: context
            .read<DiscountWatcherBloc>()
            .state
            .filtersCategoriesIndex
            .isEmpty,
      );

  Widget _myDiscountButton(
    BuildContext context,
  ) =>
      TextButton(
        key: KWidgetkeys.screen.discounts.addDiscountButton,
        onPressed: () => context.goNamed(KRoute.myDiscounts.name),
        style: KButtonStyles.whiteButtonStyle,
        child: Text(context.l10n.offerDiscount),
      );
}
