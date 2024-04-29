import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FooterWidget extends SliverMultiBoxAdaptorWidget {
  FooterWidget({
    required this.isDesk,
    required this.gridDelegate,
    super.key,
  }) : super(
          delegate: SliverChildBuilderDelegate(
            (context, index) => index - (isDesk ? 0 : 1) !=
                    KAppText.routes.length
                ? index != 0 || isDesk
                    ? TextButton(
                        key: KWidgetkeys.widget.footer.buttonsKey
                            .elementAt(index - (isDesk ? 0 : 1)),
                        style: KButtonStyles.transparentButtonStyle,
                        child: Text(
                          KAppText.footerButtonText(context)
                              .elementAt(index - (isDesk ? 0 : 1)),
                          // +
                          //     (!isDesktop &&
                          //             buttonsText
                          //                 .elementAt(index)
                          //                 .contains(context.l10n.contact)
                          //         ? '\n${KMockText.email}'
                          //         : ''),
                          style: isDesk
                              ? AppTextStyle.text32
                              : index - 1 <= 4
                                  ? AppTextStyle.text24
                                  : AppTextStyle.text14,
                        ),
                        onPressed: () => context.goNamed(
                          KAppText.routes.elementAt(index - (isDesk ? 0 : 1)),
                        ),
                      )
                    : Text(
                        context.l10n.logo,
                        key: KWidgetkeys.widget.footer.logo,
                        style: AppTextStyle.text24,
                      )
                : Row(
                    children: [
                      IconWidget(
                        key: KWidgetkeys.widget.footer.likedInIcon,
                        icon: KIcon.linkedIn,
                      ),
                      KSizedBox.kWidthSizedBox24,
                      IconWidget(
                        key: KWidgetkeys.widget.footer.instagramIcon,
                        icon: KIcon.instagram,
                      ),
                      KSizedBox.kWidthSizedBox24,
                      IconWidget(
                        key: KWidgetkeys.widget.footer.facebookIcon,
                        icon: KIcon.facebook,
                      ),
                    ],
                  ),
            childCount: KAppText.routes.length + (isDesk ? 1 : 2),
          ),
        );
  final bool isDesk;
  final SliverGridDelegate gridDelegate;

  // @override
  // Widget build(BuildContext context) {
  //   final buttonsText = [
  //     context.l10n.aboutUs,
  //     context.l10n.forInvestors,
  //     context.l10n.contact,
  //     context.l10n.stories,
  //     context.l10n.discountsCoupons,
  //     context.l10n.myProfile,
  //     context.l10n.work,
  //     context.l10n.information,
  //     context.l10n.consultationOnline,
  //   ];
  //   return Container(
  //     key: KWidgetkeys.widget.footer.widget,
  //     decoration: KWidetTheme.boxDecorationCard,
  //     child: Padding(
  //       padding: isDesk
  //           ? const EdgeInsets.all(KPadding.kPaddingSize48)
  //           : const EdgeInsets.symmetric(
  //               horizontal: KPadding.kPaddingSize16,
  //               vertical: KPadding.kPaddingSize32,
  //             ),
  //       child: Column(
  //         children: [
  //           if (isDesk)
  //             Row(
  //               children: List.generate(buttonsText.length, (index) {
  //                 return Expanded(
  //                   child: _FooterImplementationWidget(
  //                     columnIndex: index,
  //                     buttonsText: buttonsText.elementAt(index),
  //                   ),
  //                 );
  //               }),
  //             )
  //           else
  //             Padding(
  //               padding: const EdgeInsets.symmetric(
  //                 horizontal: KPadding.kPaddingSize16,
  //                 vertical: KPadding.kPaddingSize32,
  //               ),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     context.l10n.logo,
  //                     key: KWidgetkeys.widget.footer.logo,
  //                     style: AppTextStyle.text24,
  //                   ),
  //                   KSizedBox.kHeightSizedBox24,
  //                   Column(
  //                     children: List.generate(buttonsText.length, (index) {
  //                       return Container(
  //                         margin: const EdgeInsets.only(
  //                           bottom: KPadding.kPaddingSize24,
  //                         ),
  //                         child: _FooterImplementationWidget(
  //                           columnIndex: index,
  //                           isDesk: false,
  //                           buttonsText: buttonsText.elementAt(index),
  //                         ),
  //                       );
  //                     }),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           if (isDesk) KSizedBox.kHeightSizedBox48,
  //           Row(
  //             children: [
  //               IconWidget(
  //                 key: KWidgetkeys.widget.footer.likedInIcon,
  //                 icon: KIcon.linkedIn,
  //               ),
  //               KSizedBox.kWidthSizedBox24,
  //               IconWidget(
  //                 key: KWidgetkeys.widget.footer.instagramIcon,
  //                 icon: KIcon.instagram,
  //               ),
  //               KSizedBox.kWidthSizedBox24,
  //               IconWidget(
  //                 key: KWidgetkeys.widget.footer.facebookIcon,
  //                 icon: KIcon.facebook,
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  RenderSliverMultiBoxAdaptor createRenderObject(BuildContext context) {
    final element = context as SliverMultiBoxAdaptorElement;
    return RenderSliverGrid(
      childManager: element,
      gridDelegate: gridDelegate,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverGrid renderObject) {
    renderObject.gridDelegate = gridDelegate;
  }

  @override
  double estimateMaxScrollOffset(
    SliverConstraints? constraints,
    int firstIndex,
    int lastIndex,
    double leadingScrollOffset,
    double trailingScrollOffset,
  ) {
    return super.estimateMaxScrollOffset(
          constraints,
          firstIndex,
          lastIndex,
          leadingScrollOffset,
          trailingScrollOffset,
        ) ??
        gridDelegate
            .getLayout(constraints!)
            .computeMaxScrollOffset(delegate.estimatedChildCount!);
  }
}
