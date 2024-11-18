import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/bloc/investors_watcher_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
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
        final title = [
          KSizedBox.kHeightSizedBox24,
          if (Config.isWeb)
            TitlePointWidget(
              title: context.l10n.provideSuggestionsFromBusinesses,
              titleKey: KWidgetkeys.screen.investors.title,
              titleSecondPart: context.l10n.orDonateHere,
              isDesk: isDesk,
              isRightArrow: false,
              titleAlignment: WrapAlignment.end,
              textAlign: TextAlign.end,
            ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else if (Config.isWeb)
            KSizedBox.kHeightSizedBox24,
          InvestorsDescriptionWidget(
            isDesk: isDesk,
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox40
          else if (Config.isWeb)
            KSizedBox.kHeightSizedBox24,
          Center(
            child: Text(
              context.l10n.provenFunds,
              key: KWidgetkeys.screen.investors.fundsTitle,
              style: AppTextStyle.materialThemeDisplayMedium,
            ),
          ),
        ];
        return BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<InvestorsWatcherBloc>().add(
                    const InvestorsWatcherEvent.started(),
                  );
            }
          },
          child: BlocListener<InvestorsWatcherBloc, InvestorsWatcherState>(
            listener: (context, state) => context.dialog.showGetErrorDialog(
              error: state.failure?.value(context),
              onPressed: () => context
                  .read<InvestorsWatcherBloc>()
                  .add(const InvestorsWatcherEvent.started()),
            ),
            child: FocusTraversalGroup(
              child: Semantics(
                child: CustomScrollView(
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
                      sliver: SliverList.builder(
                        itemBuilder: (context, index) => title.elementAt(index),
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: false,
                        itemCount: title.length,
                      ),
                    ),
                    FundsWidgetList(
                      isDesk: isDesk,
                      padding: padding,
                    ),
                    SliverToBoxAdapter(
                      child: isDesk
                          ? KSizedBox.kHeightSizedBox50
                          : KSizedBox.kHeightSizedBox24,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
