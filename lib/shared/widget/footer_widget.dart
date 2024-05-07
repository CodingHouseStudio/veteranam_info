import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kozak/shared/shared.dart';

class FooterWidget extends SliverChildBuilderDelegate {
  FooterWidget({
    required this.isDesk,
  }) : super(
          (context, index) => index - (isDesk ? 0 : 1) !=
                  KWidgetkeys.widget.footer.buttonsKey.length
              ? index != 0 || isDesk
                  ? Padding(
                      padding: isDesk
                          ? EdgeInsets.zero
                          : EdgeInsets.only(
                              bottom: index % 3 == 0
                                  ? KPadding.kPaddingSize24
                                  : index <= 3
                                      ? KPadding.kPaddingSize8
                                      : 0,
                            ),
                      child: TextButton(
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
                          style: AppTextStyle.text32.copyWith(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: isDesk
                                ? null
                                : index <= 3
                                    ? KSize.kFont24
                                    : KSize.kFont14,
                          ),
                        ),
                        onPressed: () => context.goNamedWithScroll(
                          KAppText.routes(
                            hasAccount: context
                                    .read<AuthenticationBloc>()
                                    .state
                                    .status ==
                                AuthenticationStatus.authenticated,
                          ).elementAt(index - (isDesk ? 0 : 1)),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                        bottom: KPadding.kPaddingSize24,
                        left: KPadding.kPaddingSize8,
                      ),
                      child: Text(
                        context.l10n.logo,
                        key: KWidgetkeys.widget.footer.logo,
                        style: AppTextStyle.text24,
                      ),
                    )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: KPadding.kPaddingSize8,
                  ),
                  child: Row(
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
                ),
          childCount:
              KWidgetkeys.widget.footer.buttonsKey.length + (isDesk ? 1 : 2),
        );
  final bool isDesk;
}
