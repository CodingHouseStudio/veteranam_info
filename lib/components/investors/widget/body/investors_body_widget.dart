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

        return MultiBlocListener(
          listeners: [
            BlocListener<NetworkCubit, NetworkStatus>(
              listener: (context, state) {
                if (state == NetworkStatus.network) {
                  context.read<InvestorsWatcherBloc>().add(
                        const InvestorsWatcherEvent.started(),
                      );
                }
              },
            ),
            BlocListener<InvestorsWatcherBloc, InvestorsWatcherState>(
              listener: (context, state) => context.dialog.showGetErrorDialog(
                error: state.failure?.value(context),
                onPressed: () => context
                    .read<InvestorsWatcherBloc>()
                    .add(const InvestorsWatcherEvent.started()),
              ),
            ),
            if (!Config.isWeb)
              BlocListener<AppVersionCubit, AppVersionState>(
                listener: (context, state) =>
                    context.dialog.showMobUpdateAppDialog(
                  hasNewVersion: state.mobHasNewBuild,
                ),
              ),
          ],
          child: CustomScrollView(
            key: ScaffoldKeys.scroll,
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              NetworkBanner(isDesk: isDesk, isTablet: isTablet),
              if (Config.isWeb)
                NavigationBarWidget(
                  isDesk: isDesk,
                  isTablet: isTablet,
                  pageName: context.l10n.provenFunds,
                ),
              SliverPadding(
                padding: padding,
                sliver: InvestorsTitleWidget(isDesk: isDesk),
              ),
              if (isDesk)
                KSizedBox.kHeightSizedBox32.toSliver
              else
                KSizedBox.kHeightSizedBox24.toSliver,
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
        );
      },
    );
  }
}
