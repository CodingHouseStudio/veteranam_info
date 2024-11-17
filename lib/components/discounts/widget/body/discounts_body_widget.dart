import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discounts/bloc/bloc.dart';
import 'package:veteranam/components/discounts/discounts.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountsBodyWidget extends StatelessWidget {
  const DiscountsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (PlatformEnumFlutter.isWebDesktop) {
      return const _DiscountsBodyWidget(
        scrollController: null,
      );
    }
    return const _DiscountMobBodyWidget();
  }
}

class _DiscountsBodyWidget extends StatelessWidget {
  const _DiscountsBodyWidget({required this.scrollController});
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkStatus>(
      listener: (context, state) {
        if (state == NetworkStatus.network) {
          context.read<DiscountWatcherBloc>().add(
                DiscountWatcherEvent.started(isEnglish: context.isEnglish),
              );
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
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
          final scaffold = FocusTraversalGroup(
            child: Semantics(
              child: Stack(
                children: [
                  Scaffold(
                    resizeToAvoidBottomInset: true,
                    bottomNavigationBar: Config.isWeb
                        ? null
                        : const MobNavigationWidget(
                            index: 0,
                          ),
                    appBar: AppBar(
                      backgroundColor: AppColors.materialThemeWhite,
                      toolbarHeight: KSize.kAppBarHeight,
                    ),
                    body: CustomScrollView(
                      key: KWidgetkeys.widget.scaffold.scroll,
                      cacheExtent: KDimensions.listCacheExtent,
                      slivers: [
                        if (!Config.isWeb)
                          BlocBuilder<NetworkCubit, NetworkStatus>(
                            builder: (context, state) {
                              if (state.isOffline) {
                                SliverPersistentHeader(
                                  pinned: true,
                                  delegate: NetworkStatusBanner.getSliverHeader(
                                    isDesk: isDesk,
                                    isTablet: isTablet,
                                    networkStatus: state,
                                  ),
                                );
                              }
                              return const SliverToBoxAdapter();
                            },
                          ),
                        if (Config.isWeb)
                          SliverPersistentHeader(
                            delegate: NavbarWidget.getSliverHeader(
                              isDesk: isDesk,
                              isTablet: isTablet,
                              pageName: context.l10n.discount,
                            ),
                          ),
                        SliverPadding(
                          padding: padding,
                          sliver: SliverToBoxAdapter(
                            child: TitlePointWidget(
                              title: context.l10n.specialOffers,
                              titleKey: KWidgetkeys.screen.discounts.title,
                              titleSecondPart:
                                  context.l10n.forVeteransAndTheirFamilies,
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
                        ),
                        SliverPadding(
                          padding: padding,
                          sliver: SliverToBoxAdapter(
                            child: DiscountsFilterWidget(isDesk: isDesk),
                          ),
                        ),
                        SliverPadding(
                          padding: padding,
                          sliver: isDesk
                              ? DiscountsDeskWidgetList(
                                  maxHeight: constraints.maxHeight,
                                )
                              : const DiscountsMobWidgetList(),
                        ),
                      ],
                      controller: scrollController,
                      // semanticChildCount: null,
                    ),
                  ),
                ],
              ),
            ),
          );
          return Config.isWeb ? scaffold : SafeArea(child: scaffold);
        },
      ),
    );

    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     final isDesk =
    //         constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
    //     final isTablet =
    //         constraints.maxWidth > KPlatformConstants.
    // minWidthThresholdTablet;
    //     final padding = EdgeInsets.symmetric(
    //       horizontal: (isDesk
    //           ? KPadding.kPaddingSize90 +
    //               ((constraints.maxWidth >
    //                       KPlatformConstants.maxWidthThresholdTablet)
    //                   ? (constraints.maxWidth -
    //                           KPlatformConstants.maxWidthThresholdTablet) /
    //                       2
    //                   : 0)
    //           : KPadding.kPaddingSize16),
    //     );
    //     final body = [
    //       NavbarWidget(isDesk: isDesk, isTablet: isTablet),
    //       KSizedBox.kHeightSizedBox24,
    //       if (Config.isWeb) ...[
    //         Padding(
    //           padding: padding,
    //           child: TitlePointWidget(
    //             title: context.l10n.specialOffers,
    //             titleKey: KWidgetkeys.screen.discounts.title,
    //             titleSecondPart: context.l10n.forVeteransAndTheirFamilies,
    //             // pointText: context.l10n.discounts,
    //             // pointKey: KWidgetkeys.screen.discounts.
    //             // titlePoint,
    //             isDesk: isDesk,
    //             titleSecondPartPadding: const EdgeInsets.only(
    //               left: KPadding.kPaddingSize72,
    //             ),
    //             iconCrossAxisAlignment: CrossAxisAlignment.end,
    //             isRightArrow: false,
    //           ),
    //         ),
    //         if (isDesk)
    //           KSizedBox.kHeightSizedBox40
    //         else
    //           KSizedBox.kHeightSizedBox24,
    //       ],
    //       Padding(
    //         padding: padding,
    //         child: DiscountsFilterWidget(isDesk: isDesk),
    //       ),
    //       if (isDesk)
    //         KSizedBox.kHeightSizedBox40
    //       else
    //         KSizedBox.kHeightSizedBox24,
    //       Padding(
    //         padding: padding,
    //         child: DiscountsWidgetList(
    //           isDesk: isDesk,
    //         ),
    //       ),
    //       if (isDesk)
    //         KSizedBox.kHeightSizedBox40
    //       else
    //         KSizedBox.kHeightSizedBox24,
    //     ];
    //     return BlocListener<DiscountWatcherBloc, DiscountWatcherState>(
    //       listener: (context, state) {
    //         if (state.failure != null) {
    //           context.dialog.showGetErrorDialog(
    //             error: state.failure!.value(context),
    //             onPressed: () {},
    //             // I think this event is not necessary for Stream, but
    //             // I think it's better to give
    //             // the user imaginary control over it

    //             // () => context
    //             //     .read<DiscountWatcherBloc>()
    //             //     .add(const DiscountWatcherEvent.started()),
    //           );
    //         }
    //         if (context.read<UserEmailFormBloc>().state.emailEnum.show &&
    //             state.itemsLoaded ==
    //                 (context.read<DiscountConfigCubit>().state.loadingItems *
    //                     (context
    //                             .read<DiscountConfigCubit>()
    //                             .state
    //                             .emailScrollCount +
    //                         1))) {
    //           if (Config.isWeb) {
    //             context.dialog.showUserEmailDialog(
    //               context.read<DiscountConfigCubit>().state.emailCloseDelay,
    //             );
    //           } else {
    //             context.read<MobileRatingCubit>().showDialog();
    //           }
    //         }
    //       },
    //       child: BlocListener<NetworkCubit, NetworkStatus>(
    //         listener: (context, state) {
    //           if (state == NetworkStatus.network) {
    //             context.read<DiscountWatcherBloc>().add(
    //                   DiscountWatcherEvent.started(
    //                     isEnglish: context.isEnglish,
    //                   ),
    //                 );
    //           }
    //         },
    //         child: BlocListener<UrlCubit, UrlEnum?>(
    //           listener: (context, state) async {
    //             if (state != null) {
    //               context.dialog.showSnackBardTextDialog(
    //                 state.value(context),
    //                 duration: const Duration(milliseconds: 4000),
    //               );
    //               context.read<UrlCubit>().reset();
    //             }
    //           },
    //           child: ListView.builder(
    //             key: KWidgetkeys.widget.scaffold.scroll,
    //             // primary: true,
    //             controller: scrollController,
    //             restorationId: 'discount_page',
    //             itemCount: body.length,
    //             addAutomaticKeepAlives: false,
    //             addRepaintBoundaries: false,
    //             itemBuilder: (context, index) => body.elementAt(index),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );

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
}

class _DiscountMobBodyWidget extends StatefulWidget {
  const _DiscountMobBodyWidget();

  @override
  State<_DiscountMobBodyWidget> createState() => _DiscountMobBodyWidgetState();
}

class _DiscountMobBodyWidgetState extends State<_DiscountMobBodyWidget> {
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
    return _DiscountsBodyWidget(scrollController: _scrollController);
  }

  void _onScroll() {
    if (_isBottom &&
        context.read<DiscountWatcherBloc>().state.loadingStatus ==
            LoadingStatus.loaded) {
      context.read<DiscountWatcherBloc>().add(
            const DiscountWatcherEvent.loadNextItems(),
          );
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= maxScroll * 0.9;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
