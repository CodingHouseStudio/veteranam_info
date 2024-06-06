import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:go_router/go_router.dart';
import 'package:kozak/shared/shared.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      children: _support(context: context, isDesk: isDesk),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _sections(isDesk: isDesk, context: context),
                    ),
                  ),
                  if (Config.isDevelopment)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _information(isDesk: isDesk, context: context),
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _contact(isDesk: isDesk, context: context),
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
              ..._support(context: context, isDesk: isDesk),
              KSizedBox.kHeightSizedBox40,
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _sections(isDesk: isDesk, context: context),
                    ),
                  ),
                  if (Config.isDevelopment)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                            _information(isDesk: isDesk, context: context),
                      ),
                    )
                  else
                    Expanded(
                      child: Column(
                        children: _contact(isDesk: isDesk, context: context),
                      ),
                    ),
                ],
              ),
              if (Config.isDevelopment) ...[
                KSizedBox.kHeightSizedBox40,
                ..._contact(isDesk: isDesk, context: context),
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
  static List<Widget> _sections({
    required bool isDesk,
    required BuildContext context,
  }) =>
      [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize10),
          child: Text(
            context.l10n.sections,
            key: KWidgetkeys.widget.footer.sections,
            style: isDesk
                ? AppTextStyle.materialThemeBodyLargeHint
                : AppTextStyle.materialThemeBodyMediumHint,
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox16,
        _button(
          key: KWidgetkeys.widget.footer.discountsButton,
          isDesk: true,
          text: context.l10n.discounts,
          onPressed: () => context.goNamed(KRoute.discounts.name),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox12,
        _button(
          key: KWidgetkeys.widget.footer.informationButton,
          isDesk: true,
          text: context.l10n.information,
          onPressed: () => context.goNamed(KRoute.information.name),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox12,
        _button(
          key: KWidgetkeys.widget.footer.investorsButton,
          isDesk: true,
          text: context.l10n.forInvestors,
          onPressed: () => context.goNamed(KRoute.investors.name),
        ),
        if (Config.isDevelopment) ...[
          if (isDesk)
            KSizedBox.kHeightSizedBox16
          else
            KSizedBox.kHeightSizedBox12,
          _button(
            key: KWidgetkeys.widget.footer.workButton,
            isDesk: true,
            text: context.l10n.work,
            onPressed: () => context.goNamed(KRoute.work.name),
          ),
          if (isDesk)
            KSizedBox.kHeightSizedBox16
          else
            KSizedBox.kHeightSizedBox12,
          _button(
            key: KWidgetkeys.widget.footer.storyButton,
            isDesk: true,
            text: context.l10n.stories,
            onPressed: () => context.goNamed(KRoute.stories.name),
          ),
        ],
      ];
  static List<Widget> _information({
    required bool isDesk,
    required BuildContext context,
  }) =>
      [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize10),
          child: Text(
            context.l10n.information,
            key: KWidgetkeys.widget.footer.information,
            style: isDesk
                ? AppTextStyle.materialThemeBodyLargeHint
                : AppTextStyle.materialThemeBodyMediumHint,
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox16,
        _button(
          key: KWidgetkeys.widget.footer.aboutUsButton,
          isDesk: true,
          text: context.l10n.aboutUs,
          onPressed: () => context.goNamed(KRoute.aboutUs.name),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox12,
        _button(
          key: KWidgetkeys.widget.footer.profileButton,
          isDesk: true,
          text: context.l10n.myProfile,
          onPressed: () => context.read<AuthenticationBloc>().state.status ==
                  AuthenticationStatus.authenticated
              ? context.goNamed(KRoute.profile.name)
              : context.goNamed(KRoute.login.name),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox16
        else
          KSizedBox.kHeightSizedBox12,
        _button(
          key: KWidgetkeys.widget.footer.consultationOnlineButton,
          isDesk: true,
          text: context.l10n.consultationOnline,
          onPressed: () => context.goNamed(KRoute.consultation.name),
        ),
      ];
  static List<Widget> _contact({
    required bool isDesk,
    required BuildContext context,
  }) =>
      [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize4),
          child: Text(
            context.l10n.contacts,
            key: KWidgetkeys.widget.footer.contact,
            style: isDesk
                ? AppTextStyle.materialThemeBodyLargeHint
                : AppTextStyle.materialThemeBodyMediumHint,
          ),
        ),
        KSizedBox.kHeightSizedBox16,
        Row(
          children: [
            KIcon.meil.copyWith(
              key: KWidgetkeys.widget.footer.emailIcon,
            ),
            Expanded(
              child: Markdown(
                key: KWidgetkeys.widget.footer.emailText,
                padding: const EdgeInsets.only(
                  left: KPadding.kPaddingSize8,
                ),
                data: KAppText.email,
                styleSheet: MarkdownStyleSheet(
                  a: isDesk
                      ? AppTextStyle.materialThemeTitleMedium
                          .copyWith(color: AppColors.materialThemeBlack)
                      : AppTextStyle.materialThemeTitleSmall
                          .copyWith(color: AppColors.materialThemeBlack),
                ),
                shrinkWrap: true,
                onTapLink: (text, href, title) async {
                  final emailUri = Uri(
                    scheme: 'mailto',
                    path: KAppText.email,
                  );

                  if (await canLaunchUrl(emailUri)) {
                    await launchUrl(emailUri);
                  }
                },
              ),
            ),
          ],
        ),
      ];
  static List<Widget> _support({
    required bool isDesk,
    required BuildContext context,
  }) =>
      [
        Text(
          context.l10n.doYouWantSupportOurProject,
          key: KWidgetkeys.widget.footer.title,
          style: isDesk
              ? AppTextStyle.materialThemeDisplaySmall
              : AppTextStyle.materialThemeHeadlineMedium,
        ),
        KSizedBox.kHeightSizedBox16,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.widget.footer.button,
          text: context.l10n.contact,
          onPressed: null,
          isDesk: isDesk,
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
        onPressed: onPressed,
        child: Text(text),
      );
}
