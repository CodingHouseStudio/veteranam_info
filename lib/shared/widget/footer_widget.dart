import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class FooterWidget extends SingleChildRenderObjectWidget {
  FooterWidget({
    required this.isDesk,
    required this.isTablet,
    super.key,
  }) : super(
          child: SliverPadding(
            padding: isDesk
                ? const EdgeInsets.only(
                    bottom: KPadding.kPaddingSize32,
                    top: KPadding.kPaddingSize32,
                    right: KPadding.kPaddingSize32,
                    left: KPadding.kPaddingSize46,
                  )
                : isTablet
                    ? const EdgeInsets.all(
                        KPadding.kPaddingSize46,
                      )
                    : const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize32,
                        horizontal: KPadding.kPaddingSize16,
                      ),
            sliver: _FooterWidgetList(isDesk: isDesk, isTablet: isTablet),
          ),
        );

  final bool isDesk;
  final bool isTablet;

  @override
  RenderDecoratedSliver createRenderObject(BuildContext context) {
    return RenderDecoratedSliver(
      decoration: KWidgetTheme.boxDecorationFooter,
    );
  }
}

class _FooterWidgetList extends StatelessWidget {
  const _FooterWidgetList({
    required this.isDesk,
    required this.isTablet,
  });
  final bool isDesk;
  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    final body = isTablet
        ? [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _Support(isTablet: isTablet),
                ),
                Expanded(
                  child: _Sections(isTablet: isTablet),
                ),
                if (Config.isDevelopment)
                  Expanded(
                    child: _Information(isTablet: isTablet),
                  ),
                Expanded(
                  child: _Contact(isTablet: isTablet),
                ),
                SocialMediaLinks(
                  isDesk: isTablet,
                  padding: isTablet
                      ? KPadding.kPaddingSize24
                      : KPadding.kPaddingSize16,
                  instagramKey: FooterKeys.instagramIcon,
                  linkedInKey: FooterKeys.likedInIcon,
                  facebookKey: FooterKeys.facebookIcon,
                ),
              ],
            ),
            KSizedBox.kHeightSizedBox56,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                KIcon.logo78.copyWith(key: FooterKeys.logo),
                Expanded(
                  child: Wrap(
                    spacing: KPadding.kPaddingSize8,
                    runSpacing: KPadding.kPaddingSize8,
                    alignment: WrapAlignment.end,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    children: [
                      Text(
                        '${KAppText.madeBy}  |',
                        key: FooterKeys.madeBy,
                        style:
                            AppTextStyle.materialThemeBodyLargeNeutralVariant35,
                        textAlign: TextAlign.end,
                      ),
                      const _FooterRightsReservedWidget(),
                      _PrivacyPolice(isDesk: isDesk),
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
            _Support(isTablet: isTablet),
            KSizedBox.kHeightSizedBox40,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: _Sections(isTablet: isTablet),
                ),
                if (Config.isDevelopment)
                  Expanded(
                    flex: 2,
                    child: _Information(isTablet: isTablet),
                  )
                else
                  Expanded(
                    flex: 3,
                    child: _Contact(isTablet: isTablet),
                  ),
              ],
            ),
            if (Config.isDevelopment) ...[
              KSizedBox.kHeightSizedBox40,
              _Contact(isTablet: isTablet),
            ],
            KSizedBox.kHeightSizedBox40,
            SocialMediaLinks(
              isDesk: isTablet,
              padding:
                  isTablet ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
              instagramKey: FooterKeys.instagramIcon,
              linkedInKey: FooterKeys.likedInIcon,
              facebookKey: FooterKeys.facebookIcon,
            ),
            KSizedBox.kHeightSizedBox40,
            Align(
              key: FooterKeys.logo,
              alignment: Alignment.centerLeft,
              child: KIcon.logo,
            ),
            KSizedBox.kHeightSizedBox24,
            Text(
              '${KAppText.madeBy}  | ',
              key: FooterKeys.madeBy,
              style: AppTextStyle.materialThemeLabelSmallNeutralVariant35,
            ),
            KSizedBox.kHeightSizedBox4,
            Row(
              children: [
                const Expanded(
                  child: _FooterRightsReservedWidget(),
                ),
                KSizedBox.kWidthSizedBox8,
                Expanded(
                  child: _PrivacyPolice(isDesk: isDesk),
                ),
                KSizedBox.kWidthSizedBox3,
                Align(
                  alignment: Alignment.centerRight,
                  child: InfoVersionWidget(isDesk: isDesk),
                ),
              ],
            ),
          ];
    return SliverList.builder(
      itemBuilder: (context, index) => body.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: body.length,
    );
  }
}

class _FooterRightsReservedWidget extends StatelessWidget {
  const _FooterRightsReservedWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.l10n.allRightsReserved}  |',
      key: FooterKeys.rightReserved,
      style: AppTextStyle.materialThemeBodyLargeNeutralVariant35,
    );
  }
}

class _Sections extends StatelessWidget {
  const _Sections({
    required this.isTablet,
  });

  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: isTablet ? KPadding.kPaddingSize8 : KPadding.kPaddingSize4,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize10),
          child: Text(
            context.l10n.sections,
            key: FooterKeys.sections,
            style: isTablet
                ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
                : AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _Button(
          widgetKey: FooterKeys.discountsButton,
          text: context.l10n.discounts,
          onPressed: () => context.goNamed(KRoute.discounts.name),
        ),
        if (Config.isDevelopment)
          _Button(
            widgetKey: FooterKeys.informationButton,
            text: context.l10n.information,
            onPressed: () => context.goNamed(KRoute.information.name),
          ),
        _Button(
          widgetKey: FooterKeys.investorsButton,
          text: context.l10n.investors,
          onPressed: () => context.goNamed(KRoute.support.name),
        ),
        if (Config.isDevelopment) ...[
          _Button(
            widgetKey: FooterKeys.workButton,
            text: context.l10n.work,
            onPressed: () => context.goNamed(KRoute.work.name),
          ),
          _Button(
            widgetKey: FooterKeys.storyButton,
            text: context.l10n.stories,
            onPressed: () => context.goNamed(KRoute.stories.name),
          ),
        ],
      ],
    );
  }
}

class _Information extends StatelessWidget {
  const _Information({
    required this.isTablet,
  });

  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: isTablet ? KPadding.kPaddingSize8 : KPadding.kPaddingSize4,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: KPadding.kPaddingSize10),
          child: Text(
            context.l10n.information,
            key: FooterKeys.information,
            style: isTablet
                ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
                : AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _Button(
          widgetKey: FooterKeys.aboutUsButton,
          text: context.l10n.aboutUs,
          onPressed: () => context.goNamed(KRoute.aboutUs.name),
        ),
        _Button(
          widgetKey: FooterKeys.profileButton,
          text: context.l10n.myProfile,
          onPressed: () => context.read<AuthenticationBloc>().state.status ==
                  AuthenticationStatus.authenticated
              ? context.goNamed(KRoute.profile.name)
              : context.goNamed(KRoute.login.name),
        ),
        _Button(
          widgetKey: FooterKeys.consultationOnlineButton,
          text: context.l10n.consultationOnline,
          onPressed: () => context.goNamed(KRoute.consultation.name),
        ),
      ],
    );
  }
}

class _Contact extends StatelessWidget {
  const _Contact({
    required this.isTablet,
  });

  final bool isTablet;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: KPadding.kPaddingSize16,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            context.l10n.contacts,
            key: FooterKeys.contact,
            style: isTablet
                ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
                : AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
        ),
        EmailButtonWidget(
          key: FooterKeys.emailButton,
          isDesk: isTablet,
        ),
      ],
    );
  }
}

class _Support extends StatelessWidget {
  const _Support({
    required this.isTablet,
  });

  final bool isTablet;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: KPadding.kPaddingSize16,
      children: [
        Text(
          context.l10n.doYouWantSupportOurProject,
          key: FooterKeys.title,
          style: isTablet
              ? AppTextStyle.materialThemeDisplaySmall
              : AppTextStyle.materialThemeHeadlineMedium,
        ),
        // if (Config.isWeb)
        //   Align(
        //     alignment: Alignment.centerLeft,
        //     child: BuyMeACoffeeWidget(
        //       key: FooterKeys.button,
        //     ),
        //   )
        // else
        DoubleButtonWidget(
          widgetKey: FooterKeys.button,
          text: context.l10n.contact,
          onPressed: () => context.goNamed(KRoute.feedback.name),
          isDesk: isTablet,
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.onPressed,
    required this.text,
    required this.widgetKey,
  });

  final void Function() onPressed;
  final String text;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: widgetKey,
      onPressed: onPressed,
      style: KButtonStyles.footerButtonTransparent,
      child: Text(text),
    );
  }
}

class SocialMediaLinks extends StatelessWidget {
  const SocialMediaLinks({
    required this.isDesk,
    required this.instagramKey,
    required this.linkedInKey,
    required this.facebookKey,
    this.padding = KPadding.kPaddingSize24,
    super.key,
  });

  final bool isDesk;
  final double padding;
  final Key instagramKey;
  final Key linkedInKey;
  final Key facebookKey;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: padding,
        children: [
          _SocialButton(
            widgetKey: linkedInKey,
            url: KAppText.linkedIn,
            image: KIcon.linkedIn,
          ),
          _SocialButton(
            widgetKey: instagramKey,
            url: KAppText.instagram,
            image: KIcon.instagram,
          ),
          _SocialButton(
            widgetKey: facebookKey,
            url: KAppText.facebook,
            image: KIcon.facebook,
          ),
        ],
      );
    } else {
      return Wrap(
        spacing: padding,
        runSpacing: padding,
        children: [
          _SocialButton(
            widgetKey: linkedInKey,
            url: KAppText.linkedIn,
            image: KIcon.linkedIn,
          ),
          _SocialButton(
            widgetKey: instagramKey,
            url: KAppText.instagram,
            image: KIcon.instagram,
          ),
          _SocialButton(
            widgetKey: facebookKey,
            url: KAppText.facebook,
            image: KIcon.facebook,
          ),
        ],
      );
    }
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.url,
    required this.image,
    required this.widgetKey,
  });

  final String url;
  final Widget image;
  final Key widgetKey;

  @override
  Widget build(BuildContext context) {
    return IconButtonWidget(
      key: widgetKey,
      onPressed: () => context
        ..read<UrlCubit>().launchUrl(
          url: url,
          // mode: LaunchMode.externalApplication,
        ),
      icon: image,
      background: AppColors.materialThemeSourceSeed,
    );
  }
}

class _PrivacyPolice extends StatelessWidget {
  const _PrivacyPolice({
    required this.isDesk,
  });

  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: FooterKeys.privacyPolicy,
      onPressed: () => context.goNamed(KRoute.privacyPolicy.name),
      style: isDesk
          ? KButtonStyles.withoutStyleAligmentBottomLeft
          : KButtonStyles.withoutStyle,
      child: Text(
        context.l10n.privacyPolicy,
        textAlign: TextAlign.end,
        style: isDesk
            ? AppTextStyle.materialThemeBodyLargeNeutralVariant35
            : AppTextStyle.materialThemeLabelSmallNeutralVariant35,
      ),
    );
  }
}
