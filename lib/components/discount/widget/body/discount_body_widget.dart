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
        BlocListener<UrlCubit, UrlEnum?>(
          listener: (context, state) {
            if (state != null) {
              context.dialog.showSnackBardTextDialog(
                state.value(
                  context,
                ),
                duration: const Duration(milliseconds: 4000),
              );
              context.read<UrlCubit>().reset();
            }
          },
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
      child: LayoutBuilder(
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
          return CustomScrollView(
            cacheExtent: KDimensions.listCacheExtent,
            slivers: [
              NetworkBanner(isDesk: isDesk, isTablet: isTablet),
              if (Config.isWeb)
                NavigationBarWidget(
                  isDesk: isDesk,
                  isTablet: isTablet,
                ),
              if (isDesk)
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
                        isDesk: isDesk,
                      );
                    }
                    return SliverMainAxisGroup(
                      slivers: [
                        SliverToBoxAdapter(
                          child: BackButtonWidget(
                            backPageName: context.l10n.toDiscounts,
                            pathName: KRoute.discounts.name,
                            buttonKey: KWidgetkeys.screen.discount.backButton,
                            textKey: KWidgetkeys.screen.discount.backText,
                          ),
                        ),
                        if (isDesk)
                          KSizedBox.kHeightSizedBox32.toSliver
                        else
                          KSizedBox.kHeightSizedBox8.toSliver,
                        DiscountInformationWidget(
                          isDesk: isDesk,
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
