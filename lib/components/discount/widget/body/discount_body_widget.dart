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
    return BlocListener<UrlCubit, UrlEnum?>(
      listener: (context, state) async {
        if (state != null) {
          context.dialog.showSnackBardTextDialog(
            state.value(
              context: context,
              copyMessage: context.l10n.copyPhoneNumber,
            ),
            duration: const Duration(milliseconds: 4000),
          );
          context.read<UrlCubit>().reset();
        }
      },
      child: BlocListener<NetworkCubit, NetworkStatus>(
        listener: (context, state) {
          if (state == NetworkStatus.network) {
            context.read<DiscountWatcherBloc>().add(
                  DiscountWatcherEvent.started(
                    discount: discount,
                    discountId: discountId,
                  ),
                );
          }
        },
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final isDesk =
                constraints.maxWidth > KPlatformConstants.minWidthThresholdDesk;
            final isTablet = constraints.maxWidth >
                KPlatformConstants.minWidthThresholdTablet;

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
            return FocusTraversalGroup(
              child: Semantics(
                child: CustomScrollView(
                  cacheExtent: KDimensions.listCacheExtent,
                  slivers: [
                    NetworkBanner(isDesk: isDesk, isTablet: isTablet),
                    NavigationBarWidget(
                      isDesk: isDesk,
                      isTablet: isTablet,
                      pageName: context.l10n.discounts,
                    ),
                    if (isDesk)
                      KSizedBox.kHeightSizedBox32.toSliver
                    else
                      KSizedBox.kHeightSizedBox8.toSliver,
                    SliverPadding(
                      padding: padding,
                      sliver: const SliverToBoxAdapter(
                        child: DiscountBackButton(),
                      ),
                    ),
                    if (isDesk)
                      KSizedBox.kHeightSizedBox32.toSliver
                    else
                      KSizedBox.kHeightSizedBox8.toSliver,
                    SliverPadding(
                      padding: padding,
                      sliver: DiscountInformationWidget(
                        isDesk: isDesk,
                      ),
                    ),
                    KSizedBox.kHeightSizedBox40.toSliver,
                  ],
                  // semanticChildCount: null,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
