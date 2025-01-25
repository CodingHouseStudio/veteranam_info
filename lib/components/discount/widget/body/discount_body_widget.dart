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
    return MultiBlocListener(
      listeners: [
        const BlocListener<UrlCubit, UrlEnum?>(
          listener: UrlCubitExtension.listener,
        ),
        BlocListener<NetworkCubit, NetworkStatus>(
          listener: (context, state) {
            if (state == NetworkStatus.network) {
              context.read<DiscountWatcherBloc>().add(
                    DiscountWatcherEvent.started(
                      discountId,
                    ),
                  );
            }
          },
        ),
      ],
      child: BlocBuilder<AppLayoutCubit, AppVersionEnum>(
        buildWhen: (previous, current) => previous.isDesk != current.isDesk,
        builder: (context, state) {
          final padding = EdgeInsets.symmetric(
            horizontal: state.isDesk
                ? AppVersionEnum.desk.horizontalPadding
                : AppVersionEnum.mobile.horizontalPadding,
          );
          return CustomScrollView(
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              const NetworkBanner(),
              if (Config.isWeb) const NavigationBarWidget(),
              if (state.isDesk)
                KSizedBox.kHeightSizedBox32.toSliver
              else
                KSizedBox.kHeightSizedBox8.toSliver,
              SliverPadding(
                padding: padding,
                sliver: BlocSelector<DiscountWatcherBloc, DiscountWatcherState,
                    bool>(
                  selector: (state) => state.failure.linkIsWrong,
                  // buildWhen: (previous, current) =>
                  //     current.failure == DiscountFailure.linkWrong &&
                  //     previous.failure != DiscountFailure.linkWrong,
                  builder: (context, linkIsWrong) {
                    if (linkIsWrong) {
                      return DiscountWrongLinkWidget(
                        isDesk: state.isDesk,
                      );
                    }
                    return SliverMainAxisGroup(
                      slivers: [
                        SliverToBoxAdapter(
                          child: BackButtonWidget(
                            backPageName: context.l10n.toDiscounts,
                            pathName: KRoute.discounts.name,
                            buttonKey: DiscountKeys.backButton,
                            textKey: DiscountKeys.backText,
                          ),
                        ),
                        if (state.isDesk)
                          KSizedBox.kHeightSizedBox32.toSliver
                        else
                          KSizedBox.kHeightSizedBox8.toSliver,
                        DiscountInformationWidget(
                          isDesk: state.isDesk,
                        ),
                      ],
                    );
                  },
                ),
              ),
              KSizedBox.kHeightSizedBox40.toSliver,
            ],
            // semanticChildCount: null,
          );
        },
      ),
    );
  }
}
