import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/home/home.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return HomeBlocListener(
      childWidget: BlocBuilder<AppLayoutCubit, AppVersionEnum>(
        builder: (context, state) {
          final padding = EdgeInsets.symmetric(
            horizontal: state.horizontalPadding,
          );
          return CustomScrollView(
            key: ScaffoldKeys.scroll,
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              const NetworkBanner(),
              const NavigationBarWidget(),
              SliverPadding(
                padding: padding,
                sliver: HomeSectionsWidget(
                  isDesk: state.isDesk,
                  isTablet: state.isTablet,
                ),
              ),
              SliverPadding(
                padding: padding,
                sliver: state.isDesk
                    ? const FAQSectionDeskWidget()
                    : const FaqSectionMobWidget(),
              ),
              SliverToBoxAdapter(
                child: state.isDesk
                    ? KSizedBox.kHeightSizedBox160
                    : state.isTablet
                        ? KSizedBox.kHeightSizedBox64
                        : KSizedBox.kHeightSizedBox48,
              ),
              SliverPadding(
                padding: padding,
                sliver: FooterWidget(
                  isTablet: state.isTablet,
                  isDesk: state.isDesk,
                ),
              ),
              KSizedBox.kHeightSizedBox30.toSliver,
            ],
          );
        },
      ),
    );
  }
}
