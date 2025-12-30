import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/components/investors/investors.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class InvestorsBodyWidget extends StatelessWidget {
  const InvestorsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InvestorsBlocListener(
      childWidget: CustomScrollView(
        key: ScaffoldKeys.scroll,
        cacheExtent: KDimensions.listCacheExtent,
        slivers: [
          const NetworkBanner(),
          if (Config.isWeb) const NavigationBarWidget(),
          BlocBuilder<AppLayoutBloc, AppLayoutState>(
            buildWhen: (previous, current) =>
                previous.appVersionEnum.isDesk != current.appVersionEnum.isDesk,
            builder: (context, state) {
              return SliverCenterWidget(
                appVersionEnum: state.appVersionEnum,
                sliver: SliverMainAxisGroup(
                  slivers: [
                    KSizedBox.kHeightSizedBox24.toSliver,
                    InvestorsTitleWidget(
                      isDesk: state.appVersionEnum.isDesk,
                    ),
                    if (state.appVersionEnum.isDesk)
                      KSizedBox.kHeightSizedBox32.toSliver
                    else
                      KSizedBox.kHeightSizedBox24.toSliver,
                    FundsWidgetList(
                      isDesk: state.appVersionEnum.isDesk,
                    ),
                    if (state.appVersionEnum.isDesk)
                      KSizedBox.kHeightSizedBox50.toSliver
                    else
                      KSizedBox.kHeightSizedBox24.toSliver,
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
