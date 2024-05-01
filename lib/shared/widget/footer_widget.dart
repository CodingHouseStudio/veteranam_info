import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

class FooterWidget extends SliverChildBuilderDelegate {
  FooterWidget({
    required this.isDesk,
  }) : super(
          (context, index) => index - (isDesk ? 0 : 1) != KAppText.routes.length
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
        );
  final bool isDesk;
}
