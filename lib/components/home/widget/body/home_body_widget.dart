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
        builder: (context, appVersionEnum) => CustomScrollView(
          key: ScaffoldKeys.scroll,
          cacheExtent: KDimensions.listCacheExtent,
          slivers: [
            const NetworkBanner(),
            const NavigationBarWidget(),
            SliverCenter(
              appVersionEnum: appVersionEnum,
              sliver: SliverPadding(
                padding: appVersionEnum.paddingWithTablet,
                sliver: SliverConstrainedCrossAxis(
                  maxExtent: KPlatformConstants.maxWidthThresholdDesk,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      HomeSectionsWidget(
                        isDesk: appVersionEnum.isDesk,
                        isTablet: appVersionEnum.isTablet,
                      ),
                      if (appVersionEnum.isDesk)
                        const FAQSectionDeskWidget()
                      else
                        const FaqSectionMobWidget(),
                      if (appVersionEnum.isDesk)
                        KSizedBox.kHeightSizedBox160.toSliver
                      else if (appVersionEnum.isTablet)
                        KSizedBox.kHeightSizedBox64.toSliver
                      else
                        KSizedBox.kHeightSizedBox48.toSliver,
                      FooterWidget(
                        appVersionEnum: appVersionEnum,
                      ),
                      KSizedBox.kHeightSizedBox30.toSliver,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
