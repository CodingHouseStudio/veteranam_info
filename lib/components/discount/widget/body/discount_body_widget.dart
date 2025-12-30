import 'package:flutter/widgets.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/components/discount/discount.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountBodyWidget extends StatelessWidget {
  const DiscountBodyWidget({
    required this.discount,
    required this.discountId,
    super.key,
  });
  final DiscountModel? discount;
  final String? discountId;

  @override
  Widget build(BuildContext context) {
    return DiscountBlocListener(
      discountId: discountId,
      child: CustomScrollView(
        cacheExtent: KDimensions.listCacheExtent,
        slivers: [
          const NetworkBanner(),
          if (Config.isWeb) const NavigationBarWidget(),
          BlocBuilder<AppLayoutBloc, AppLayoutState>(
            buildWhen: (previous, current) =>
                previous.appVersionEnum.isDesk != current.appVersionEnum.isDesk,
            builder: (context, state) => SliverCenterWidget(
              appVersionEnum: state.appVersionEnum,
              sliver:
                  BlocSelector<DiscountWatcherBloc, DiscountWatcherState, bool>(
                selector: (state) => state.failure.linkIsWrong,
                builder: (context, linkIsWrong) {
                  return SliverMainAxisGroup(
                    slivers: [
                      if (state.appVersionEnum.isDesk)
                        KSizedBox.kHeightSizedBox32.toSliver
                      else
                        KSizedBox.kHeightSizedBox8.toSliver,
                      if (linkIsWrong)
                        DiscountWrongLinkWidget(
                          isDesk: state.appVersionEnum.isDesk,
                        )
                      else ...[
                        SliverToBoxAdapter(
                          child: BackButtonWidget(
                            backPageName: context.l10n.toDiscounts,
                            pathName: Config.isBusiness
                                ? KRoute.myDiscounts.name
                                : KRoute.discounts.name,
                            buttonKey: DiscountKeys.backButton,
                            textKey: DiscountKeys.backText,
                          ),
                        ),
                        if (state.appVersionEnum.isDesk)
                          KSizedBox.kHeightSizedBox32.toSliver
                        else
                          KSizedBox.kHeightSizedBox8.toSliver,
                        DiscountInformationWidget(
                          isDesk: state.appVersionEnum.isDesk,
                        ),
                      ],
                      KSizedBox.kHeightSizedBox40.toSliver,
                    ],
                  );
                },
              ),
            ),
          ),
        ],
        // semanticChildCount: null,
      ),
    );
  }
}
