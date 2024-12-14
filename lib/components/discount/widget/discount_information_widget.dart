import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/components/discount/discount.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountInformationDeskWidget extends MultiChildRenderObjectWidget {
  // Constructor for the RowSliver widget
  DiscountInformationDeskWidget({
    required this.maxHeight,
    required this.isDesk,
    super.key,
  }) : super(
          children: [
            DiscountInformationBodyWidget(
              isDesk: isDesk,
            ),
            _DiscountContactWidget(
              maxHeight: maxHeight,
              isDesk: isDesk,
            ),
          ],
        );
  final double maxHeight;
  final bool isDesk;

  // Creates the render object for this widget
  @override
  RenderRowSliver createRenderObject(BuildContext context) {
    return RenderRowSliver(leftWidthPercent: 2 / 3);
  }
}

class DiscountInformationBodyWidget extends StatelessWidget {
  const DiscountInformationBodyWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
      builder: (context, state) {
        final children = [
          if (state.discountModel.hasImages)
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxHeight: KMinMaxSize.maxHeight480,
              ),
              child: Center(
                child: DiscountImageWidget(
                  discount:
                      state.discountModel.discount.getDiscountString(context),
                  images: state.discountModel.images!,
                  borderRadius: KBorderRadius.kBorderRadius32,
                ),
              ),
            ),
          Text(
            context.l10n.eligibility,
            style: AppTextStyle.materialThemeHeadlineMedium,
          ),
          KSizedBox.kHeightSizedBox16,
          EligibilityWidget(
            eligibility: state.discountModel.eligibility,
            showFullList: true,
          ),
          KSizedBox.kHeightSizedBox32,
          Text(
            context.l10n.detail,
            style: AppTextStyle.materialThemeHeadlineMedium,
          ),
          KSizedBox.kHeightSizedBox16,
          MarkdownLinkWidget(
            text: state.discountModel.description.getTrsnslation(context),
            textStyle: AppTextStyle.materialThemeBodyLarge,
          ),
          if (state.discountModel.exclusions != null) ...[
            KSizedBox.kHeightSizedBox32,
            Text(
              context.l10n.toGetItYouNeed,
              style: AppTextStyle.materialThemeHeadlineMedium,
            ),
            KSizedBox.kHeightSizedBox16,
            MarkdownLinkWidget(
              text: state.discountModel.exclusions!.getTrsnslation(context),
              textStyle: AppTextStyle.materialThemeBodyLarge,
            ),
          ],
          if (state.discountModel.additionalDetails != null) ...[
            KSizedBox.kHeightSizedBox32,
            Text(
              state.discountModel.additionalDetails!.getTrsnslation(context),
              style: AppTextStyle.materialThemeBodyLargeNeutralVariant50,
            ),
          ],
        ];
        return SliverList.builder(
          itemBuilder: (context, index) => children.elementAt(index),
          itemCount: children.length,
        );
      },
    );
  }
}

class _DiscountContactWidget extends StatelessWidget {
  const _DiscountContactWidget({
    required this.maxHeight,
    required this.isDesk,
  });
  final double maxHeight;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverHeaderWidget(
        childWidget: ({
          required overlapsContent,
          required shrinkOffset,
        }) =>
            BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
          builder: (context, state) {
            return SkeletonizerWidget(
              isLoading: state.loadingStatus.isLoading,
              child: _DiscountContactInformationWidget(
                discount: state.discountModel,
                isDesk: isDesk,
                isLoading: state.loadingStatus.isLoading,
              ),
            );
          },
        ),
        maxMinHeight: maxHeight,
      ),
    );
  }
}

class _DiscountContactInformationWidget extends StatelessWidget {
  const _DiscountContactInformationWidget({
    required this.discount,
    required this.isDesk,
    required this.isLoading,
  });

  final bool isLoading;
  final DiscountModel discount;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DecoratedBox(
          decoration: KWidgetTheme.boxDecorationDiscountContainer,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(KPadding.kPaddingSize16),
                child: CompanyInfoWidget(
                  dateVerified: discount.dateVerified,
                  category: discount.category,
                  company: discount.company,
                  userName: discount.userName,
                  userPhoto: discount.userPhoto,
                ),
              ),
              DecoratedBox(
                decoration: KWidgetTheme.boxDecorationWidget,
                child: Padding(
                  padding: const EdgeInsets.all(KPadding.kPaddingSize16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        discount.title.getTrsnslation(context),
                        style: AppTextStyle.materialThemeHeadlineMedium,
                      ),
                      KSizedBox.kHeightSizedBox4,
                      CityListWidget(
                        key: KWidgetkeys.widget.discountCard.city,
                        isDesk: false,
                        location: discount.location,
                        subLocation: discount.subLocation,
                        showFullText: true,
                      ),
                      KSizedBox.kHeightSizedBox4,
                      ExpirationWidget(
                        expiration:
                            discount.expiration?.getTrsnslation(context),
                      ),
                      if (discount.phoneNumber != null) ...[
                        KSizedBox.kHeightSizedBox4,
                        ShowPhoneNumberWidget(
                          phoneNumber: discount.phoneNumber!,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        KSizedBox.kHeightSizedBox24,
        Align(
          alignment: Alignment.centerLeft,
          child: SharedIconListWidget(
            isDesk: isDesk,
            cardEnum: CardEnum.discount,
            cardId: discount.id,
            shareKey: const Key('share'),
            complaintKey: const Key('complaint'),
            share: '${KRoute.home.path}${KRoute.discounts.path}/${discount.id}',
            isSeparatePage: true,
            link: discount.directLink ?? discount.link,
          ),
        ),
      ],
    );
  }
}
