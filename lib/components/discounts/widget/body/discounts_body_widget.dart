import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/watcher/discount_watcher_bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountBodyWidget extends StatefulWidget {
  const DiscountBodyWidget({super.key});

  @override
  State<DiscountBodyWidget> createState() => _DiscountBodyWidgetState();
}

class _DiscountBodyWidgetState extends State<DiscountBodyWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    if (!PlatformEnumFlutter.isWebDesktop) {
      _scrollController.addListener(_onScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesk =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
        final isTablet =
            constraints.maxWidth > KPlatformConstants.minWidthThresholdTablet;
        final padding = EdgeInsets.symmetric(
          horizontal: (isDesk
              ? KPadding.kPaddingSize90 +
                  ((constraints.maxWidth >
                          KPlatformConstants.maxWidthThresholdTablet)
                      ? (constraints.maxWidth -
                              KPlatformConstants.maxWidthThresholdTablet) /
                          2
                      : 0)
              : KPadding.kPaddingSize16),
        );
        final body = [
          NavbarWidget(isDesk: isDesk, isTablet: isTablet),
          KSizedBox.kHeightSizedBox24,
          if (Config.isWeb) ...[
            Padding(
              padding: padding,
              child: TitlePointWidget(
                title: context.l10n.specialOffers,
                titleKey: KWidgetkeys.screen.discounts.title,
                titleSecondPart: context.l10n.forVeteransAndTheirFamilies,
                // pointText: context.l10n.discounts,
                // pointKey: KWidgetkeys.screen.discounts.
                // titlePoint,
                isDesk: isDesk,
                titleSecondPartPadding: const EdgeInsets.only(
                  left: KPadding.kPaddingSize72,
                ),
                iconCrossAxisAlignment: CrossAxisAlignment.end,
                isRightArrow: false,
              ),
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox40
            else
              KSizedBox.kHeightSizedBox24,
          ],
          Padding(
            padding: padding,
            child: DiscountsFilterWidget(isDesk: isDesk),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
          Padding(
            padding: padding,
            child: DiscountsWidgetList(
              isDesk: isDesk,
            ),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else
            KSizedBox.kHeightSizedBox24,
        ];
        return ListView.builder(
          // primary: true,
          controller: _scrollController,
          restorationId: 'discount_page',
          itemCount: body.length,
          addAutomaticKeepAlives: false,
          addRepaintBoundaries: false,
          itemBuilder: (context, index) => body.elementAt(index),
        );
      },
    );

    // return BlocBuilder<DiscountConfigCubit, DiscountConfigState>(
    //   builder: (context, config) {
    //     return BlocBuilder<UserEmailFormBloc, UserEmailFormState>(
    //       buildWhen: (previous, current) =>
    //           previous.emailEnum != current.emailEnum,
    //       builder: (context, emailState) {
    //         return BlocBuilder<DiscountLinkCubit, bool>(
    //           builder: (context, state) {
    //             return BlocConsumer<DiscountWatcherBloc,
    // DiscountWatcherState>(
    //               listener: (context, state) {
    //                 if (state.failure != null) {
    //                   context.dialog.showGetErrorDialog(
    //                     error: state.failure!.value(context),
    //                     onPressed: () {},
    //                     // I think this event is not necessary for Stream, but
    //                     // I think it's better to give
    //                     // the user imaginary control over it

    //                     // () => context
    //                     //     .read<DiscountWatcherBloc>()
    //                     //     .add(const DiscountWatcherEvent.started()),
    //                   );
    //                 }
    //                 if (Config.isWeb) {
    //                   if (state.itemsLoaded ==
    //                           (config.loadingItems *
    //                               (config.emailScrollCount + 1)) &&
    //                       emailState.emailEnum.show) {
    //                     context.dialog.showUserEmailDialog(
    //                       config.emailCloseDelay,
    //                       // userEmailEnum: emailState.value,
    //                       // count: emailState.count,
    //                     );
    //                   }
    //                 } else {
    //                   context.read<MobileRatingCubit>().showDialog();
    //                 }
    //               },
    //               listenWhen: (previous, current) =>
    //                   current.failure != null ||
    //                   previous.itemsLoaded != current.itemsLoaded,
    //               builder: (context, _) {
    //                 return ScaffoldAutoLoadingWidget(
    //                   loadingButtonText: context.l10n.moreDiscounts,
    //                   loadingStatus: _.loadingStatus,
    //                   cardListIsEmpty: _.filteredDiscountModelItems.isEmpty,
    //                   pageName: context.l10n.discounts,
    //                   // resetFilter: () => context.read<DiscountWatcherBloc>()
    //                   // .add(
    //                   //       const DiscountWatcherEvent.filterReset(),
    //                   //     ),
    //                   // loadDataAgain: () => context
    //                   //     .read<DiscountWatcherBloc>()
    //                   //     .add(const DiscountWatcherEvent.started()),
    //                   titleChildWidgetsFunction: ({required isDesk}) => [
    //                     KSizedBox.kHeightSizedBox24,
    //                     if (Config.isWeb) ...[
    //                       TitlePointWidget(
    //                         title: context.l10n.specialOffers,
    //                         titleKey: KWidgetkeys.screen.discounts.title,
    //                         titleSecondPart:
    //                             context.l10n.forVeteransAndTheirFamilies,
    //                         // pointText: context.l10n.discounts,
    //                         // pointKey: KWidgetkeys.screen.discounts.
    //                         // titlePoint,
    //                         isDesk: isDesk,
    //                         titleSecondPartPadding: const EdgeInsets.only(
    //                           left: KPadding.kPaddingSize72,
    //                         ),
    //                         iconCrossAxisAlignment: CrossAxisAlignment.end,
    //                         isRightArrow: false,
    //                       ),
    //                       if (isDesk)
    //                         KSizedBox.kHeightSizedBox40
    //                       else
    //                         KSizedBox.kHeightSizedBox24,
    //                     ],
    //                     if (isDesk)
    //                       Row(
    //                         children: [
    //                           Expanded(
    //                             child: _filter(
    //                               context: context,
    //                               isDesk: isDesk,
    //                             ),
    //                           ),
    //                           if (Config.isBusiness)
    // _myDiscountButton(context),
    //                         ],
    //                       )
    //                     else ...[
    //                       _filter(
    //                         context: context,
    //                         isDesk: isDesk,
    //                       ),
    //                       if (Config.isBusiness) ...[
    //                         KSizedBox.kHeightSizedBox8,
    //                         _myDiscountButton(context),
    //                       ],
    //                       KSizedBox.kHeightSizedBox24,
    //                       AdvancedFilterMob(
    //                         key: KWidgetkeys.screen.discounts
    // .advancedFilterMob,
    //                       ),
    //                     ],
    //                     if (isDesk)
    //                       KSizedBox.kHeightSizedBox40
    //                     else
    //                       KSizedBox.kHeightSizedBox24,
    //                   ],
    //                   mainRightChildWidget: AdvancedFilterDesk(
    //                     key: KWidgetkeys.screen.discounts.advancedFilterDesk,
    //                   ),
    //                   mainChildWidgetsFunction: ({required isDesk}) => [
    //                     if (_.discountModelItems.isEmpty &&
    //                         _.loadingStatus == LoadingStatus.loaded &&
    //                         Config.isDevelopment)
    //                       MockButtonWidget(
    //                         key: KWidgetkeys.screen.discounts.buttonMock,
    //                         onPressed: () {
    //                           GetIt.I
    //                               .get<IDiscountRepository>()
    //                               .addMockDiscountItems();
    //                           context
    //                               .read<DiscountWatcherBloc>()
    //                               .add(const DiscountWatcherEvent.started());
    //                         },
    //                       )
    //                     else
    //                       ...discountsWidgetList(
    //                         context: context,
    //                         isDesk: isDesk,
    //                       ),
    //                     // LoadingButton(
    //                     //   widgetKey: KWidgetkeys.screen.discounts.button,
    //                     //   text: context.l10n.moreDiscounts,
    //                     //   onPressed: () => context
    //                     //       .read<DiscountWatcherBloc>()
    //                     //       .add(const DiscountWatcherEvent.
    //                     // loadNextItems()),
    //                     //   isDesk: isDesk,
    //                     // ),
    //                     if (isDesk)
    //                       KSizedBox.kHeightSizedBox40
    //                     else
    //                       KSizedBox.kHeightSizedBox24,
    //                   ],
    //                   loadFunction: () => context
    //                       .read<DiscountWatcherBloc>()
    //                       .add(const DiscountWatcherEvent.loadNextItems()),
    //                 );
    //               },
    //             );
    //           },
    //         );
    //       },
    //     );
    //   },
    // );
  }

  void _onScroll() {
    if (_isBottom &&
        context.read<DiscountWatcherBloc>().state.loadingStatus !=
            LoadingStatus.listLoadedFull) {
      context.read<DiscountWatcherBloc>().add(
            const DiscountWatcherEvent.loadNextItems(),
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
