import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/discount/bloc/discount_watcher_bloc.dart';
import 'package:veteranam/components/discount/discount.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountInformationWidget extends StatelessWidget {
  const DiscountInformationWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return const _DiscountInformationDeskWidget();
    } else {
      return const SliverMainAxisGroup(
        slivers: [
          SliverToBoxAdapter(
            child: _DiscountContactInformationWidget(isDesk: false),
          ),
          SliverToBoxAdapter(child: KSizedBox.kHeightSizedBox24),
          DiscountInformationBodyWidget(isDesk: false),
        ],
      );
    }
  }
}

class _DiscountInformationDeskWidget extends StatelessWidget {
  const _DiscountInformationDeskWidget();

  @override
  Widget build(BuildContext context) {
    return const SliverCrossAxisGroup(
      slivers: [
        SliverCrossAxisExpanded(
          flex: 5,
          sliver: DiscountInformationBodyWidget(
            isDesk: true,
          ),
        ),
        SliverCrossAxisExpanded(flex: 3, sliver: _DiscountContactWidget()),
      ],
    );
  }
}

// class _DiscountInformationDeskWidget extends MultiChildRenderObjectWidget {
//   // Constructor for the RowSliver widget
//   const _DiscountInformationDeskWidget()
//       : super(
//           children: const [
//             DiscountInformationBodyWidget(
//               isDesk: true,
//             ),
//             _DiscountContactWidget(),
//           ],
//         );

//   // Creates the render object for this widget
//   @override
//   RenderRowSliver createRenderObject(BuildContext context) {
//     return RenderRowSliver(leftWidthPercent: 3 / 5);
//   }
// }

class DiscountInformationBodyWidget extends StatelessWidget {
  const DiscountInformationBodyWidget({required this.isDesk, super.key});
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Language>(
      builder: (context, state) {
        return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
          builder: (context, state) {
            final children = [
              if (state.discountModel.hasImages)
                DiscountImageWidget(
                  discount:
                      state.discountModel.discount.getDiscountString(context),
                  images: state.discountModel.images!,
                  borderRadius: KBorderRadius.kBorderRadius32,
                ),
              Text(
                '${context.l10n.eligibility}:',
                style: AppTextStyle.materialThemeHeadlineMedium,
              ),
              KSizedBox.kHeightSizedBox16,
              EligibilityWidget(
                eligibility: state.discountModel.eligibility,
                showFullList: true,
              ),
              KSizedBox.kHeightSizedBox32,
              Text(
                '${context.l10n.details}:',
                style: AppTextStyle.materialThemeHeadlineMedium,
              ),
              KSizedBox.kHeightSizedBox16,
              MarkdownLinkWidget(
                text: state.discountModel.description.getTrsnslation(context),
                textStyle: AppTextStyle.materialThemeBodyLarge,
              ),
              if (state.discountModel.requirements != null) ...[
                KSizedBox.kHeightSizedBox32,
                Text(
                  context.l10n.toGetItYouNeed,
                  style: AppTextStyle.materialThemeHeadlineMedium,
                ),
                KSizedBox.kHeightSizedBox16,
                MarkdownLinkWidget(
                  text:
                      state.discountModel.requirements!.getTrsnslation(context),
                  textStyle: AppTextStyle.materialThemeBodyLarge,
                ),
              ],
              if (state.discountModel.exclusions != null) ...[
                KSizedBox.kHeightSizedBox32,
                MarkdownLinkWidget(
                  text: state.discountModel.exclusions!.getTrsnslation(context),
                  textStyle:
                      AppTextStyle.materialThemeBodyLargeNeutralVariant50,
                ),
              ],
            ];
            return SkeletonizerWidget(
              isLoading: state.loadingStatus.isLoading,
              isSliver: true,
              highlightColor: AppColors.materialThemeWhite,
              baseColor: AppColors.materialThemeKeyColorsNeutral,
              child: SliverList.builder(
                itemBuilder: (context, index) => children.elementAt(index),
                itemCount: children.length,
              ),
            );
          },
        );
      },
    );
  }
}

class _DiscountContactWidget extends StatelessWidget {
  const _DiscountContactWidget();

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(left: KPadding.kPaddingSize60),
      sliver: SliverPersistentHeader(
        pinned: true,
        delegate: SliverHeaderWidget(
          childWidget: ({
            required overlapsContent,
            required shrinkOffset,
          }) =>
              const _DiscountContactInformationWidget(
            isDesk: true,
          ),
          maxMinHeight: KMinMaxSize.maxHeight640,
        ),
      ),
    );
  }
}

class _DiscountContactInformationWidget extends StatelessWidget {
  const _DiscountContactInformationWidget({
    required this.isDesk,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Language>(
      builder: (context, state) {
        return BlocBuilder<DiscountWatcherBloc, DiscountWatcherState>(
          builder: (context, state) {
            return SkeletonizerWidget(
              isLoading: state.loadingStatus.isLoading,
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: KWidgetTheme.boxDecorationDiscountContainer,
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(KPadding.kPaddingSize16),
                          child: CompanyInfoWidget(
                            dateVerified: state.discountModel.dateVerified,
                            category: state.discountModel.category,
                            company: state.discountModel.company,
                            userName: state.discountModel.userName,
                            userPhoto: state.discountModel.userPhoto,
                          ),
                        ),
                        DecoratedBox(
                          decoration: KWidgetTheme.boxDecorationWidget,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: KPadding.kPaddingSize16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: KPadding.kPaddingSize16,
                                  ),
                                  child: Text(
                                    state.discountModel.title
                                        .getTrsnslation(context),
                                    style: AppTextStyle
                                        .materialThemeHeadlineMedium,
                                  ),
                                ),
                                KSizedBox.kHeightSizedBox4,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: KPadding.kPaddingSize16,
                                  ),
                                  child: CityListWidget(
                                    key: KWidgetkeys.widget.discountCard.city,
                                    isDesk: false,
                                    location: state.discountModel.location,
                                    subLocation:
                                        state.discountModel.subLocation,
                                    showFullText: true,
                                  ),
                                ),
                                KSizedBox.kHeightSizedBox4,
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: KPadding.kPaddingSize16,
                                  ),
                                  child: ExpirationWidget(
                                    expiration: state.discountModel.expiration
                                        ?.getTrsnslation(context),
                                  ),
                                ),
                                if (state.discountModel.phoneNumber !=
                                    null) ...[
                                  KSizedBox.kHeightSizedBox4,
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: KPadding.kPaddingSize8,
                                    ),
                                    child: ShowPhoneNumberWidget(
                                      phoneNumber:
                                          state.discountModel.phoneNumber!,
                                    ),
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
                      cardId: state.discountModel.id,
                      shareKey: const Key('share'),
                      complaintKey: const Key('complaint'),
                      showShare: !Config.isBusiness ||
                          state.discountModel.status == DiscountState.published,
                      share:
                          '${KRoute.home.path}${KRoute.discounts.path}/${state.discountModel.id}',
                      isSeparatePage: true,
                      link: state.discountModel.directLink ??
                          state.discountModel.link,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
