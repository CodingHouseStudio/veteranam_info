import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';

abstract class FooterWidget {
  static List<Widget> get({
    required BuildContext context,
    required bool isDesk,
  }) =>
      isDesk
          ? [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.doYouWantSupportOurProject,
                          key: KWidgetkeys.widget.footer.title,
                          style: AppTextStyle.materialThemeDisplaySmall,
                        ),
                        KSizedBox.kHeightSizedBox16,
                        DoubleButtonWidget(
                          key: KWidgetkeys.widget.footer.button,
                          text: context.l10n.contact,
                          onPressed: null,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.l10n.sections,
                          key: KWidgetkeys.widget.footer.sections,
                          style: AppTextStyle.materialThemeBodyLargeHint,
                        ),
                        KSizedBox.kHeightSizedBox24,
                        _button(
                          key: KWidgetkeys.widget.footer.discountsButton,
                          isDesk: true,
                          text: context.l10n.discounts,
                          onPressed: () =>
                              context.goNamed(KRoute.discounts.name),
                        ),
                        KSizedBox.kHeightSizedBox16,
                        _button(
                          key: KWidgetkeys.widget.footer.informationButton,
                          isDesk: true,
                          text: context.l10n.information,
                          onPressed: () =>
                              context.goNamed(KRoute.information.name),
                        ),
                        KSizedBox.kHeightSizedBox16,
                        _button(
                          key: KWidgetkeys.widget.footer.investorsButton,
                          isDesk: true,
                          text: context.l10n.forInvestors,
                          onPressed: () =>
                              context.goNamed(KRoute.investors.name),
                        ),
                        if (Config.isDevelopment) ...[
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.footer.workButton,
                            isDesk: true,
                            text: context.l10n.work,
                            onPressed: () => context.goNamed(KRoute.work.name),
                          ),
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.footer.storyButton,
                            isDesk: true,
                            text: context.l10n.stories,
                            onPressed: () =>
                                context.goNamed(KRoute.stories.name),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (Config.isDevelopment)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.information,
                            key: KWidgetkeys.widget.footer.information,
                            style: AppTextStyle.materialThemeBodyLargeHint,
                          ),
                          KSizedBox.kHeightSizedBox24,
                          _button(
                            key: KWidgetkeys.widget.footer.aboutUsButton,
                            isDesk: true,
                            text: context.l10n.aboutUs,
                            onPressed: () =>
                                context.goNamed(KRoute.aboutUs.name),
                          ),
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.footer.profileButton,
                            isDesk: true,
                            text: context.l10n.myProfile,
                            onPressed: () =>
                                context.goNamed(KRoute.profile.name),
                          ),
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys
                                .widget.footer.consultationOnlineButton,
                            isDesk: true,
                            text: context.l10n.consultationOnline,
                            onPressed: () =>
                                context.goNamed(KRoute.consultation.name),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.l10n.contacts,
                          key: KWidgetkeys.widget.footer.contact,
                          style: AppTextStyle.materialThemeBodyLargeHint,
                        ),
                        KSizedBox.kHeightSizedBox24,
                        TextButton(
                          key: KWidgetkeys.widget.footer.emailButton,
                          style: KButtonStyles.zeroPaddingButtonStyle,
                          onPressed: () => context.goNamed(KRoute.contact.name),
                          child: Row(
                            children: [
                              KIcon.meil.copyWith(
                                key: KWidgetkeys.widget.footer.emailIcon,
                              ),
                              KSizedBox.kWidthSizedBox8,
                              const Expanded(
                                child: Text(
                                  KAppText.email,
                                  style: AppTextStyle.materialThemeTitleMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconWidget(
                        key: KWidgetkeys.widget.footer.likedInIcon,
                        icon: KImage.linkedIn,
                        background: AppColors.materialThemeSourceSeed,
                      ),
                      KSizedBox.kHeightSizedBox24,
                      IconWidget(
                        key: KWidgetkeys.widget.footer.instagramIcon,
                        icon: KImage.instagram,
                        background: AppColors.materialThemeSourceSeed,
                      ),
                      KSizedBox.kHeightSizedBox24,
                      IconWidget(
                        key: KWidgetkeys.widget.footer.facebookIcon,
                        icon: KImage.facebook,
                        background: AppColors.materialThemeSourceSeed,
                      ),
                    ],
                  ),
                ],
              ),
              KSizedBox.kHeightSizedBox56,
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    key: KWidgetkeys.widget.footer.logo,
                    height: KSize.kPixel80,
                    width: KSize.kPixel140,
                    child: KImage.logo,
                  ),
                  Expanded(
                    child: Text(
                      KAppText.madeBy,
                      key: KWidgetkeys.widget.footer.madeBy,
                      style: AppTextStyle.materialThemeBodyLargeHint,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  // KSizedBox.kWidthSizedBox16,
                  // const VerticalDivider(
                  //   thickness: 1,
                  //   color: AppColors
                  //       .materialThemeRefNeutralVariantNeutralVariant35,
                  // ),
                  KSizedBox.kWidthSizedBox16,
                  Text(
                    context.l10n.allRightsReserved,
                    key: KWidgetkeys.widget.footer.rightReserved,
                    style: AppTextStyle.materialThemeBodyLargeHint,
                  ),
                  // KSizedBox.kWidthSizedBox16,
                  // const VerticalDivider(
                  //   thickness: 1,
                  //   color: AppColors
                  //       .materialThemeRefNeutralVariantNeutralVariant35,
                  // ),
                  KSizedBox.kWidthSizedBox16,
                  Text(
                    context.l10n.privacyPolicy,
                    key: KWidgetkeys.widget.footer.privacyPolicy,
                    style: AppTextStyle.materialThemeBodyLargeHint,
                  ),
                  KSizedBox.kHeightSizedBox90,
                ],
              ),
            ]
          : [
              Text(
                context.l10n.doYouWantSupportOurProject,
                key: KWidgetkeys.widget.footer.title,
                style: AppTextStyle.materialThemeHeadlineMedium,
              ),
              KSizedBox.kHeightSizedBox16,
              Align(
                alignment: Alignment.centerLeft,
                child: DoubleButtonWidget(
                  key: KWidgetkeys.widget.footer.button,
                  text: context.l10n.contact,
                  onPressed: null,
                ),
              ),
              KSizedBox.kHeightSizedBox40,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          context.l10n.sections,
                          key: KWidgetkeys.widget.footer.sections,
                          style: AppTextStyle.materialThemeBodyMediumHint,
                        ),
                        KSizedBox.kHeightSizedBox16,
                        _button(
                          key: KWidgetkeys.widget.footer.discountsButton,
                          isDesk: false,
                          text: context.l10n.discounts,
                          onPressed: () =>
                              context.goNamed(KRoute.discounts.name),
                        ),
                        KSizedBox.kHeightSizedBox12,
                        _button(
                          key: KWidgetkeys.widget.footer.informationButton,
                          isDesk: false,
                          text: context.l10n.information,
                          onPressed: () =>
                              context.goNamed(KRoute.information.name),
                        ),
                        KSizedBox.kHeightSizedBox12,
                        _button(
                          key: KWidgetkeys.widget.footer.investorsButton,
                          isDesk: false,
                          text: context.l10n.forInvestors,
                          onPressed: () =>
                              context.goNamed(KRoute.investors.name),
                        ),
                        if (Config.isDevelopment) ...[
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.footer.workButton,
                            isDesk: true,
                            text: context.l10n.work,
                            onPressed: () => context.goNamed(KRoute.work.name),
                          ),
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.footer.storyButton,
                            isDesk: true,
                            text: context.l10n.stories,
                            onPressed: () =>
                                context.goNamed(KRoute.stories.name),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (Config.isDevelopment)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            context.l10n.information,
                            key: KWidgetkeys.widget.footer.information,
                            style: AppTextStyle.materialThemeBodyMediumHint,
                          ),
                          KSizedBox.kHeightSizedBox16,
                          _button(
                            key: KWidgetkeys.widget.footer.aboutUsButton,
                            isDesk: false,
                            text: context.l10n.aboutUs,
                            onPressed: () =>
                                context.goNamed(KRoute.aboutUs.name),
                          ),
                          KSizedBox.kHeightSizedBox12,
                          _button(
                            key: KWidgetkeys.widget.footer.profileButton,
                            isDesk: false,
                            text: context.l10n.myProfile,
                            onPressed: () =>
                                context.goNamed(KRoute.profile.name),
                          ),
                          KSizedBox.kHeightSizedBox12,
                          _button(
                            key: KWidgetkeys
                                .widget.footer.consultationOnlineButton,
                            isDesk: false,
                            text: context.l10n.consultationOnline,
                            onPressed: () =>
                                context.goNamed(KRoute.consultation.name),
                          ),
                        ],
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            context.l10n.contacts,
                            key: KWidgetkeys.widget.footer.contact,
                            style: AppTextStyle.materialThemeBodyLargeHint,
                          ),
                          KSizedBox.kHeightSizedBox16,
                          TextButton(
                            key: KWidgetkeys.widget.footer.emailButton,
                            style: KButtonStyles.zeroPaddingButtonStyle,
                            onPressed: () =>
                                context.goNamed(KRoute.contact.name),
                            child: Row(
                              children: [
                                KIcon.meil.copyWith(
                                  key: KWidgetkeys.widget.footer.emailIcon,
                                ),
                                KSizedBox.kWidthSizedBox8,
                                const Expanded(
                                  child: Text(
                                    KAppText.email,
                                    style:
                                        AppTextStyle.materialThemeTitleMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              if (Config.isDevelopment) ...[
                KSizedBox.kHeightSizedBox40,
                Text(
                  context.l10n.contacts,
                  key: KWidgetkeys.widget.footer.contact,
                  style: AppTextStyle.materialThemeBodyLargeHint,
                ),
                KSizedBox.kHeightSizedBox16,
                TextButton(
                  key: KWidgetkeys.widget.footer.emailButton,
                  style: KButtonStyles.zeroPaddingButtonStyle,
                  onPressed: () => context.goNamed(KRoute.contact.name),
                  child: Row(
                    children: [
                      KIcon.meil.copyWith(
                        key: KWidgetkeys.widget.footer.emailIcon,
                      ),
                      KSizedBox.kWidthSizedBox8,
                      const Expanded(
                        child: Text(
                          KAppText.email,
                          style: AppTextStyle.materialThemeTitleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              KSizedBox.kHeightSizedBox40,
              Wrap(
                children: [
                  IconWidget(
                    key: KWidgetkeys.widget.footer.likedInIcon,
                    icon: KImage.linkedIn,
                    background: AppColors.materialThemeSourceSeed,
                  ),
                  KSizedBox.kWidthSizedBox16,
                  IconWidget(
                    key: KWidgetkeys.widget.footer.instagramIcon,
                    icon: KImage.instagram,
                    background: AppColors.materialThemeSourceSeed,
                  ),
                  KSizedBox.kWidthSizedBox16,
                  IconWidget(
                    key: KWidgetkeys.widget.footer.facebookIcon,
                    icon: KImage.facebook,
                    background: AppColors.materialThemeSourceSeed,
                  ),
                ],
              ),
              KSizedBox.kHeightSizedBox40,
              Container(
                key: KWidgetkeys.widget.footer.logo,
                alignment: Alignment.centerLeft,
                height: KSize.kPixel60,
                child: KImage.logo,
              ),
              KSizedBox.kHeightSizedBox24,
              Text(
                KAppText.madeBy,
                key: KWidgetkeys.widget.footer.madeBy,
                style: AppTextStyle.materialThemeBodyLargeHint,
              ),
              KSizedBox.kHeightSizedBox4,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      context.l10n.allRightsReserved,
                      key: KWidgetkeys.widget.footer.rightReserved,
                      style: AppTextStyle.materialThemeBodyLargeHint,
                    ),
                  ),
                  // KSizedBox.kWidthSizedBox8,
                  // const VerticalDivider(
                  //   thickness: 1,
                  //   color: AppColors
                  //       .materialThemeRefNeutralVariantNeutralVariant35,
                  // ),
                  KSizedBox.kWidthSizedBox8,
                  Expanded(
                    child: Text(
                      context.l10n.privacyPolicy,
                      key: KWidgetkeys.widget.footer.privacyPolicy,
                      style: AppTextStyle.materialThemeBodyLargeHint,
                    ),
                  ),
                ],
              ),
            ];
  static Widget _button({
    required bool isDesk,
    required void Function() onPressed,
    required String text,
    required Key key,
  }) =>
      TextButton(
        key: key,
        style: KButtonStyles.zeroPaddingButtonStyle,
        onPressed: onPressed,
        child: Text(text),
      );
}
