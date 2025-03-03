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
      childWidget: CustomScrollView(
        key: ScaffoldKeys.scroll,
        cacheExtent: KDimensions.listCacheExtent,
        slivers: [
          const NetworkBanner(),
          const NavigationBarWidget(),
          BlocBuilder<AppLayoutBloc, AppLayoutState>(
            builder: (context, state) => SliverCenterWidget(
              appVersionEnum: state.appVersionEnum,
              getTabletPadding: true,
              sliver: SliverMainAxisGroup(
                slivers: [
                  HomeSectionsWidget(
                    isDesk: state.appVersionEnum.isDesk,
                    isTablet: state.appVersionEnum.isTablet,
                  ),
                  if (state.appVersionEnum.isDesk)
                    const FAQSectionDeskWidget()
                  else
                    const FaqSectionMobWidget(),
                  if (state.appVersionEnum.isDesk)
                    KSizedBox.kHeightSizedBox160.toSliver
                  else if (state.appVersionEnum.isTablet)
                    KSizedBox.kHeightSizedBox64.toSliver
                  else
                    KSizedBox.kHeightSizedBox48.toSliver,
                  FooterWidget(
                    appVersionEnum: state.appVersionEnum,
                  ),
                  KSizedBox.kHeightSizedBox30.toSliver,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
