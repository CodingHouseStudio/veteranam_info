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
        builder: (context, state) {
          final padding = EdgeInsets.symmetric(
            horizontal: state.isDesk
                ? AppVersionEnum.desk.horizontalPadding
                : AppVersionEnum.mobile.horizontalPadding,
          );

          return CustomScrollView(
            key: KWidgetkeys.widget.scaffold.scroll,
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              const NetworkBanner(),
              if (Config.isWeb) const NavigationBarWidget(),
              SliverPadding(
                padding: padding,
                sliver: InvestorsTitleWidget(isDesk: state.isDesk),
              ),
              if (state.isDesk)
                KSizedBox.kHeightSizedBox32.toSliver
              else
                KSizedBox.kHeightSizedBox24.toSliver,
              FundsWidgetList(
                isDesk: state.isDesk,
                padding: padding,
              ),
              SliverToBoxAdapter(
                child: state.isDesk
                    ? KSizedBox.kHeightSizedBox50
                    : KSizedBox.kHeightSizedBox24,
              ),
            ],
          );
        },
      ),
    );
  }
}
