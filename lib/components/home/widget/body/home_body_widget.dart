import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final aboutProjectKey = GlobalKey();
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
        final main = [
          KSizedBox.kHeightSizedBox24,
          BoxWidgetList(
            isDesk: isDesk,
            isTablet: isTablet,
            aboutProjectKey: aboutProjectKey,
          ),
          SizedBox(
            key: aboutProjectKey,
            height: KSize.kPixel48,
          ),
          Text(
            context.l10n.aboutProject,
            key: KWidgetkeys.screen.home.aboutProjecSubtitle,
            style: isDesk
                ? AppTextStyle.materialThemeDisplayMedium
                : isTablet
                    ? AppTextStyle.materialThemeDisplaySmall
                    : AppTextStyle.materialThemeHeadlineSmall,
          ),
          DiscountSection(
            isDesk: isDesk,
            isTablet: isTablet,
          ),
          if (Config.isDevelopment) ...[
            if (isTablet)
              KSizedBox.kHeightSizedBox160
            else
              KSizedBox.kHeightSizedBox40,
            InformationSection(
              isDesk: isDesk,
              isTablet: isTablet,
            ),
          ],
          if (isDesk || isTablet)
            KSizedBox.kHeightSizedBox160
          else
            KSizedBox.kHeightSizedBox40,
        ];
        return BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<HomeWatcherBloc>().add(
                    const HomeWatcherEvent.started(),
                  );
            }
          },
          child: BlocListener<UrlCubit, UrlEnum?>(
            listener: (context, state) async {
              if (state != null) {
                context.dialog.showSnackBardTextDialog(
                  state.value(context),
                  duration: const Duration(milliseconds: 4000),
                );
                context.read<UrlCubit>().reset();
              }
            },
            child: BlocListener<HomeWatcherBloc, HomeWatcherState>(
              listener: (context, state) => context.dialog.showGetErrorDialog(
                error: state.failure?.value(context),
                onPressed: () => context
                    .read<HomeWatcherBloc>()
                    .add(const HomeWatcherEvent.started()),
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
                          ),
                        ),
                      SliverPadding(
                        padding: padding,
                        sliver: SliverList.builder(
                          itemBuilder: (context, index) =>
                              main.elementAt(index),
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false,
                          itemCount: main.length,
                        ),
                      ),
                      if (isDesk)
                        SliverPadding(
                          padding: padding,
                          sliver: SliverToBoxAdapter(
                            child: FAQSectionDeskWidget(
                              isDesk: isDesk,
                              isTablet: isTablet,
                            ),
                          ),
                        )
                      else
                        FaqSectionMobWidget(
                          isTablet: isTablet,
                          padding: padding,
                        ),
                      SliverToBoxAdapter(
                        child: isDesk
                            ? KSizedBox.kHeightSizedBox160
                            : isTablet
                                ? KSizedBox.kHeightSizedBox64
                                : KSizedBox.kHeightSizedBox48,
                      ),
                      SliverPadding(
                        padding: padding,
                        sliver: FooterWidget(
                          isTablet: isTablet,
                          isDesk: isDesk,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
