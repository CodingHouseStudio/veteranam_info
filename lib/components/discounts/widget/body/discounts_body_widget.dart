import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared.dart';

part '../discounts_widget_list.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountUserEmailCubit, bool>(
      builder: (context, showEmail) {
        return BlocBuilder<DiscountLinkCubit, bool>(
          builder: (context, state) {
            return BlocConsumer<DiscountWatcherBloc, DiscountWatcherState>(
              listener: (context, state) {
                if (state.failure != null) {
                  context.dialog.showGetErrorDialog(
                    error: state.failure!.value(context),
                    onPressed: () => context
                        .read<DiscountWatcherBloc>()
                        .add(const DiscountWatcherEvent.started()),
                  );
                }
                if (state.itemsLoaded == (KDimensions.loadItems * 4) &&
                    showEmail) {
                  context.dialog.showUserEmailDialog(
                    context,
                  );
                }
              },
              listenWhen: (previous, current) =>
                  current.failure != null ||
                  previous.itemsLoaded != current.itemsLoaded,
              builder: (context, _) {
                return ScaffoldAutoLoadingWidget(
                  loadingButtonText: context.l10n.moreDiscounts,
                  loadingStatus: _.loadingStatus,
                  cardListIsEmpty: _.filteredDiscountModelItems.isEmpty,
                  pageName: context.l10n.discounts,
                  pageNameKey: KWidgetkeys.screen.discounts.title,
                  resetFilter: () => context.read<DiscountWatcherBloc>().add(
                        const DiscountWatcherEvent.filterReset(),
                      ),
                  loadDataAgain: () => context
                      .read<DiscountWatcherBloc>()
                      .add(const DiscountWatcherEvent.started()),
                  titleChildWidgetsFunction: ({required isDesk}) => [
                    KSizedBox.kHeightSizedBox24,
                    if (KTest.testIsWeb) ...[
                      ...TitleWidget.pointTitleWidgetList(
                        title: context.l10n.specialOffers,
                        titleKey: KWidgetkeys.screen.discounts.title,
                        titleSecondPart:
                            context.l10n.forVeteransAndTheirFamilies,
                        // pointText: context.l10n.discounts,
                        // pointKey: KWidgetkeys.screen.discounts.titlePoint,
                        isDesk: isDesk,
                        titleSecondPartPadding: const EdgeInsets.only(
                          left: KPadding.kPaddingSize72,
                        ),
                        iconCrossAxisAlignment: CrossAxisAlignment.end,
                        isRightArrow: false,
                      ),
                      if (isDesk)
                        KSizedBox.kHeightSizedBox40
                      else
                        KSizedBox.kHeightSizedBox24,
                    ],
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
                          GetIt.I
                              .get<IDiscountRepository>()
                              .addMockDiscountItems();
                          context
                              .read<DiscountWatcherBloc>()
                              .add(const DiscountWatcherEvent.started());
                        },
                      )
                    else
                      ...discountsWidgetList(context: context, isDesk: isDesk),
                    // LoadingButton(
                    //   widgetKey: KWidgetkeys.screen.discounts.button,
                    //   text: context.l10n.moreDiscounts,
                    //   onPressed: () => context
                    //       .read<DiscountWatcherBloc>()
                    //       .add(const DiscountWatcherEvent.loadNextItems()),
                    //   isDesk: isDesk,
                    // ),
                    if (isDesk)
                      KSizedBox.kHeightSizedBox40
                    else
                      KSizedBox.kHeightSizedBox24,
                  ],
                  loadFunction: () => context
                      .read<DiscountWatcherBloc>()
                      .add(const DiscountWatcherEvent.loadNextItems()),
                );
              },
            );
          },
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
              getENFilter: (item) => item.categoryEN,
              getUAFilter: (item) => item.category,
              numberGetList: context
                  .read<DiscountWatcherBloc>()
                  .state
                  .locationDiscountModelItems,
            ),
        isDesk: isDesk,
        // onResetValue: () => context.read<DiscountWatcherBloc>().add(
        //       const DiscountWatcherEvent.filterReset(),
        //     ),
        isSelected: (index) => context
            .read<DiscountWatcherBloc>()
            .state
            .filtersCategories
            .contains(index),
        onSelected: (index) => context.read<DiscountWatcherBloc>().add(
              DiscountWatcherEvent.filterCategory(
                index,
              ),
            ),
        fullLength: context
            .read<DiscountWatcherBloc>()
            .state
            .locationDiscountModelItems
            .length,
        filterIsEmpty:
            context.read<DiscountWatcherBloc>().state.filtersCategories.isEmpty,
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
