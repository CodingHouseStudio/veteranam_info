import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
import 'package:veteranam/components/home/widget/faq_section_widget.dart'
    deferred as faq_section_widget;
import 'package:veteranam/components/home/widget/home_section_widget.dart'
    deferred as home_section_widget;
import 'package:veteranam/shared/shared_flutter.dart';
import 'package:veteranam/shared/widget/footer_widget.dart'
    deferred as footer_widget;
import 'package:veteranam/shared/widget/navigation_bar_widget.dart'
    deferred as nav_bar_widget;
// import 'package:veteranam/components/home/bloc/home_watcher_bloc.dart';
// import 'package:veteranam/components/home/home.dart';
// import 'package:veteranam/shared/shared_flutter.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

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
                  state.value(context: context),
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
                      // NetworkBanner(isDesk: isDesk, isTablet: isTablet),
                      FutureBuilder(
                        future: nav_bar_widget.loadLibrary(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return nav_bar_widget.NavigationBarWidget(
                              isDesk: isDesk,
                              isTablet: isTablet,
                            );
                          } else {
                            return const SliverToBoxAdapter();
                          }
                        },
                      ),
                      FutureBuilder(
                        future: home_section_widget.loadLibrary(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return SliverPadding(
                              padding: padding,
                              sliver: home_section_widget.HomeSectionsWidget(
                                isDesk: isDesk,
                                isTablet: isTablet,
                              ),
                            );
                          } else {
                            return const SliverToBoxAdapter();
                          }
                        },
                      ),
                      FutureBuilder(
                        future: faq_section_widget.loadLibrary(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return faq_section_widget.FaqSectionWidget(
                              isDesk: isDesk,
                              padding: padding,
                              isTablet: isTablet,
                            );
                          } else {
                            return const SliverToBoxAdapter();
                          }
                        },
                      ),
                      SliverToBoxAdapter(
                        child: isDesk
                            ? KSizedBox.kHeightSizedBox160
                            : isTablet
                                ? KSizedBox.kHeightSizedBox64
                                : KSizedBox.kHeightSizedBox48,
                      ),
                      FutureBuilder(
                        future: footer_widget.loadLibrary(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return SliverPadding(
                              padding: padding.copyWith(
                                bottom: KPadding.kPaddingSize30,
                              ),
                              sliver: footer_widget.FooterWidget(
                                isTablet: isTablet,
                                isDesk: isDesk,
                              ),
                            );
                          } else {
                            return const SliverToBoxAdapter();
                          }
                        },
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
