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
                  context.read<HomeWatcherBloc>().add(
                        const HomeWatcherEvent.started(),
                      );
                }
              },
            ),
            BlocListener<UrlCubit, UrlEnum?>(
              listener: (context, state) async {
                if (state != null) {
                  context.dialog.showSnackBardTextDialog(
                    state.value(context),
                    duration: const Duration(milliseconds: 4000),
                  );
                  context.read<UrlCubit>().reset();
                }
              },
            ),
            BlocListener<HomeWatcherBloc, HomeWatcherState>(
              listener: (context, state) => context.dialog.showGetErrorDialog(
                error: state.failure?.value(context),
                onPressed: () => context
                    .read<HomeWatcherBloc>()
                    .add(const HomeWatcherEvent.started()),
              ),
            ),
          ],
          child: CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              NetworkBanner(isDesk: isDesk, isTablet: isTablet),
              NavigationBarWidget(
                isDesk: isDesk,
                isTablet: isTablet,
              ),
              SliverPadding(
                padding: padding,
                sliver: HomeSectionsWidget(
                  isDesk: isDesk,
                  isTablet: isTablet,
                ),
              ),
              SliverPadding(
                padding: padding,
                sliver: isDesk
                    ? const FAQSectionDeskWidget()
                    : const FaqSectionMobWidget(),
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
              KSizedBox.kHeightSizedBox30.toSliver,
            ],
          ),
        );
      },
    );
  }
}
