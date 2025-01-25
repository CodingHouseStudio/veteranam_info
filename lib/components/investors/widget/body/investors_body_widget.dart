import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InvestorsBlocListener(
      childWidget: BlocBuilder<AppLayoutCubit, AppVersionEnum>(
        buildWhen: (previous, current) => previous.isDesk != current.isDesk,
        builder: (context, appVersionEnum) => CustomScrollView(
          key: ScaffoldKeys.scroll,
          cacheExtent: KDimensions.listCacheExtent,
          slivers: [
            const NetworkBanner(),
            if (Config.isWeb) const NavigationBarWidget(),
            SliverCenter(
              appVersionEnum: appVersionEnum,
              sliver: SliverPadding(
                padding: appVersionEnum.paddingWithTablet,
                sliver: SliverConstrainedCrossAxis(
                  maxExtent: KPlatformConstants.maxWidthThresholdDesk,
                  sliver: SliverMainAxisGroup(
                    slivers: [
                      InvestorsTitleWidget(isDesk: appVersionEnum.isDesk),
                      if (appVersionEnum.isDesk)
                        KSizedBox.kHeightSizedBox32.toSliver
                      else
                        KSizedBox.kHeightSizedBox24.toSliver,
                      FundsWidgetList(
                        isDesk: appVersionEnum.isDesk,
                      ),
                      if (appVersionEnum.isDesk)
                        KSizedBox.kHeightSizedBox50.toSliver
                      else
                        KSizedBox.kHeightSizedBox24.toSliver,
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
