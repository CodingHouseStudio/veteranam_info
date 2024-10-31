import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_flutter.dart';

abstract class FooterWidget {
  static List<Widget> get({
    required BuildContext context,
    required bool isTablet,
    required bool isDesk,
  }) =>
      isTablet
          ? [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _support(
                        context: context,
                        isTablet: isTablet,
                        isDesk: isDesk,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _sections(
                        isTablet: isTablet,
                        context: context,
                      ),
                    ),
                  ),
                  if (Config.isDevelopment)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _information(
                          isTablet: isTablet,
                          context: context,
                        ),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _contact(
                        isTablet: isTablet,
                        context: context,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: socialMediaLinks(
                      isTablet: isTablet,
                      context: context,
                      padding: isTablet
                          ? KSizedBox.kHeightSizedBox24
                          : KSizedBox.kWidthSizedBox16,
                      instagramKey: KWidgetkeys.widget.footer.instagramIcon,
                      linkedInKey: KWidgetkeys.widget.footer.likedInIcon,
                      facebookKey: KWidgetkeys.widget.footer.facebookIcon,
                    ),
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
                    child: KImage.logo(),
                  ),
                  Expanded(
                    child: Wrap(
                      spacing: KPadding.kPaddingSize8,
                      alignment: WrapAlignment.end,
                      crossAxisAlignment: WrapCrossAlignment.end,
                      children: [
                        Text(
                          '${KAppText.madeBy}  |',
                          key: KWidgetkeys.widget.footer.madeBy,
                          style: AppTextStyle
                              .materialThemeBodyLargeNeutralVariant35,
                          textAlign: TextAlign.end,
                        ),
                        // KSizedBox.kWidthSizedBox16,
                        // const VerticalDivider(
                        //   thickness: 1,
                        //   color: AppColors
                        //
                        // .materialThemeRefNeutralVariantNeutralVariant35,
                        // ),
                        //KSizedBox.kWidthSizedBox16,
                        Text(
                          '${context.l10n.allRightsReserved}  |',
                          key: KWidgetkeys.widget.footer.rightReserved,
                          style: AppTextStyle
                              .materialThemeBodyLargeNeutralVariant35,
                        ),
                        // KSizedBox.kWidthSizedBox16,
                        // const VerticalDivider(
                        //   thickness: 1,
                        //   color: AppColors
                        //
                        // .materialThemeRefNeutralVariantNeutralVariant35,
                        // ),
                        //KSizedBox.kWidthSizedBox16,
                        _privacyPolice(context: context, isDesk: true),
                        // KSizedBox.kHeightSizedBox90,
                      ],
                    ),
                  ),
                  KSizedBox.kWidthSizedBox4,
                  InfoVersionWidget(
                    isDesk: isDesk,
                  ),
                ],
              ),
            ]
          : [
              ..._support(context: context, isTablet: isTablet, isDesk: isDesk),
              KSizedBox.kHeightSizedBox40,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _sections(
                        isTablet: isTablet,
                        context: context,
                      ),
                    ),
                  ),
                  if (Config.isDevelopment)
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _information(
                          isTablet: isTablet,
                          context: context,
                        ),
                      ),
                    )
                  else
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: _contact(
                          isTablet: isTablet,
                          context: context,
                        ),
                      ),
                    ),
                ],
              ),
              if (Config.isDevelopment) ...[
                KSizedBox.kHeightSizedBox40,
                ..._contact(
                  isTablet: isTablet,
                  context: context,
                ),
              ],
              KSizedBox.kHeightSizedBox40,
              Wrap(
                children: socialMediaLinks(
                  isTablet: isTablet,
                  context: context,
                  padding: isTablet
                      ? KSizedBox.kHeightSizedBox24
                      : KSizedBox.kWidthSizedBox16,
                  instagramKey: KWidgetkeys.widget.footer.instagramIcon,
                  linkedInKey: KWidgetkeys.widget.footer.likedInIcon,
                  facebookKey: KWidgetkeys.widget.footer.facebookIcon,
                ),
              ),
              KSizedBox.kHeightSizedBox40,
              Container(
                key: KWidgetkeys.widget.footer.logo,
                alignment: Alignment.centerLeft,
                height: KSize.kPixel60,
                child: KImage.logo(),
              ),
              KSizedBox.kHeightSizedBox24,
              Text(
                '${KAppText.madeBy}  | ',
                key: KWidgetkeys.widget.footer.madeBy,
                style: AppTextStyle.materialThemeLabelSmallNeutralVariant35,
              ),
              KSizedBox.kHeightSizedBox4,
              Row(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      '${context.l10n.allRightsReserved}  | ',
                      key: KWidgetkeys.widget.footer.rightReserved,
                      style:
                          AppTextStyle.materialThemeLabelSmallNeutralVariant35,
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
                    child: _privacyPolice(context: context, isDesk: false),
                  ),
                  KSizedBox.kWidthSizedBox3,
                  Align(
                    alignment: Alignment.centerRight,
                    child: InfoVersionWidget(isDesk: isDesk),
                  ),
                ],
              ),
            ];
  static List<Widget> _sections({
    required bool isTablet,
    required BuildContext context,
  }) =>
      [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize10),
          child: Text(
            context.l10n.sections,
            key: KWidgetkeys.widget.footer.sections,
            style: isTablet
                ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
                : AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox8,
        _button(
          key: KWidgetkeys.widget.footer.discountsButton,
          text: context.l10n.discounts,
          onPressed: () => context.goNamed(KRoute.discounts.name),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        if (Config.isDevelopment)
          _button(
            key: KWidgetkeys.widget.footer.informationButton,
            text: context.l10n.information,
            onPressed: () => context.goNamed(KRoute.information.name),
          ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _button(
          key: KWidgetkeys.widget.footer.investorsButton,
          text: context.l10n.investors,
          onPressed: () => context.goNamed(KRoute.support.name),
        ),
        if (Config.isDevelopment) ...[
          if (isTablet)
            KSizedBox.kHeightSizedBox8
          else
            KSizedBox.kHeightSizedBox4,
          _button(
            key: KWidgetkeys.widget.footer.workButton,
            text: context.l10n.work,
            onPressed: () => context.goNamed(KRoute.work.name),
          ),
          if (isTablet)
            KSizedBox.kHeightSizedBox8
          else
            KSizedBox.kHeightSizedBox4,
          _button(
            key: KWidgetkeys.widget.footer.storyButton,
            text: context.l10n.stories,
            onPressed: () => context.goNamed(KRoute.stories.name),
          ),
        ],
      ];
  static List<Widget> _information({
    required bool isTablet,
    required BuildContext context,
  }) =>
      [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize10),
          child: Text(
            context.l10n.information,
            key: KWidgetkeys.widget.footer.information,
            style: isTablet
                ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
                : AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox8,
        _button(
          key: KWidgetkeys.widget.footer.aboutUsButton,
          text: context.l10n.aboutUs,
          onPressed: () => context.goNamed(KRoute.aboutUs.name),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _button(
          key: KWidgetkeys.widget.footer.profileButton,
          text: context.l10n.myProfile,
          onPressed: () => context.read<AuthenticationBloc>().state.status ==
                  AuthenticationStatus.authenticated
              ? context.goNamed(KRoute.profile.name)
              : context.goNamed(KRoute.login.name),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _button(
          key: KWidgetkeys.widget.footer.consultationOnlineButton,
          text: context.l10n.consultationOnline,
          onPressed: () => context.goNamed(KRoute.consultation.name),
        ),
      ];
  static List<Widget> _contact({
    required bool isTablet,
    required BuildContext context,
  }) =>
      [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            context.l10n.contacts,
            key: KWidgetkeys.widget.footer.contact,
            style: isTablet
                ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
                : AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
        ),
        KSizedBox.kHeightSizedBox16,
        KSizedBox.kWidthSizedBox4,
        EmailButtonWidget(
          key: KWidgetkeys.widget.footer.emailButton,
          isDesk: isTablet,
          context: context,
        ),
      ];
  static List<Widget> _support({
    required bool isTablet,
    required bool isDesk,
    required BuildContext context,
  }) =>
      [
        Text(
          context.l10n.doYouWantSupportOurProject,
          key: KWidgetkeys.widget.footer.title,
          style: isTablet
              ? AppTextStyle.materialThemeDisplaySmall
              : AppTextStyle.materialThemeHeadlineMedium,
        ),
        KSizedBox.kHeightSizedBox16,
        // if (Config.isWeb)
        //   Align(
        //     alignment: Alignment.centerLeft,
        //     child: BuyMeACoffeeWidget(
        //       key: KWidgetkeys.widget.footer.button,
        //     ),
        //   )
        // else
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.widget.footer.button,
          text: context.l10n.contact,
          onPressed: () => context.goNamed(KRoute.feedback.name),
          isDesk: isTablet,
        ),
      ];
  static Widget _button({
    required void Function() onPressed,
    required String text,
    required Key key,
  }) =>
      TextButton(
        key: key,
        onPressed: onPressed,
        style: KButtonStyles.footerButtonTransparent,
        child: Text(text),
      );

  static List<Widget> socialMediaLinks({
    required bool isTablet,
    required BuildContext context,
    required Widget padding,
    required Key instagramKey,
    required Key linkedInKey,
    required Key facebookKey,
  }) =>
      [
        _socialButton(
          key: linkedInKey,
          url: KAppText.linkedIn,
          image: KImage.linkedIn(),
          context: context,
        ),
        padding,
        _socialButton(
          key: instagramKey,
          url: KAppText.instagram,
          image: KImage.instagram(),
          context: context,
        ),
        padding,
        _socialButton(
          key: facebookKey,
          url: KAppText.facebook,
          image: KImage.facebook(),
          context: context,
        ),
      ];
  static Widget _socialButton({
    required BuildContext context,
    required String url,
    required Key key,
    required Widget image,
  }) =>
      IconButtonWidget(
        key: key,
        onPressed: () => context
          ..read<UrlCubit>().launchUrl(
            url: url,
            // mode: LaunchMode.externalApplication,
          ),
        icon: image,
        background: AppColors.materialThemeSourceSeed,
      );
  static Widget _privacyPolice({
    required BuildContext context,
    required bool isDesk,
  }) =>
      TextButton(
        key: KWidgetkeys.widget.footer.privacyPolicy,
        onPressed: () => context.goNamed(KRoute.privacyPolicy.name),
        style: KButtonStyles.withoutStyle
            .copyWith(alignment: isDesk ? Alignment.bottomLeft : null),
        child: Text(
          context.l10n.privacyPolicy,
          textAlign: TextAlign.end,
          style: isDesk
              ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
              : AppTextStyle.materialThemeLabelSmallNeutralVariant35,
        ),
      );
}
