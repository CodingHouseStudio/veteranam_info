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
          child: _FooterWidgetList(
            isDesk: isDesk,
            isTablet: isTablet,
            delegate: _body(isTablet: isTablet, isDesk: isDesk),
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

  static SliverChildDelegate _body({
    required bool isTablet,
    required bool isDesk,
  }) {
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
                      ? KSizedBox.kHeightSizedBox24
                      : KSizedBox.kWidthSizedBox16,
                  instagramKey: KWidgetkeys.widget.footer.instagramIcon,
                  linkedInKey: KWidgetkeys.widget.footer.likedInIcon,
                  facebookKey: KWidgetkeys.widget.footer.facebookIcon,
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
                        style:
                            AppTextStyle.materialThemeBodyLargeNeutralVariant35,
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
                      const _FooterRightsReservedWidget(),
                      // KSizedBox.kWidthSizedBox16,
                      // const VerticalDivider(
                      //   thickness: 1,
                      //   color: AppColors
                      //
                      // .materialThemeRefNeutralVariantNeutralVariant35,
                      // ),
                      //KSizedBox.kWidthSizedBox16,
                      _PrivacyPolice(isDesk: isDesk),
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
              padding: isTablet
                  ? KSizedBox.kHeightSizedBox24
                  : KSizedBox.kWidthSizedBox16,
              instagramKey: KWidgetkeys.widget.footer.instagramIcon,
              linkedInKey: KWidgetkeys.widget.footer.likedInIcon,
              facebookKey: KWidgetkeys.widget.footer.facebookIcon,
            ),
            // Wrap(
            //   children: socialMediaLinks(
            //     isTablet: isTablet,
            //     context: context,
            //     padding: isTablet
            //         ? KSizedBox.kHeightSizedBox24
            //         : KSizedBox.kWidthSizedBox16,
            //     instagramKey: KWidgetkeys.widget.footer.instagramIcon,
            //     linkedInKey: KWidgetkeys.widget.footer.likedInIcon,
            //     facebookKey: KWidgetkeys.widget.footer.facebookIcon,
            //   ),
            // ),
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
                const Expanded(
                  child: _FooterRightsReservedWidget(),
                ),
                // KSizedBox.kWidthSizedBox8,
                // const VerticalDivider(
                //   thickness: 1,
                //   color: AppColors
                // .materialThemeRefNeutralVariantNeutralVariant35,
                // ),
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
    return SliverChildBuilderDelegate(
      (context, index) => body.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      childCount: body.length,
    );
  }
}

class _FooterWidgetList extends SingleChildRenderObjectWidget {
  _FooterWidgetList({
    required this.isDesk,
    required this.isTablet,
    required this.delegate,
  }) : super(
          child: SliverPadding(
            padding: isDesk
                ? const EdgeInsets.all(
                    KPadding.kPaddingSize32,
                  ).copyWith(left: KPadding.kPaddingSize46)
                : isTablet
                    ? const EdgeInsets.all(
                        KPadding.kPaddingSize46,
                      )
                    : const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize32,
                        horizontal: KPadding.kPaddingSize16,
                      ),
            sliver: SliverList(
              delegate: delegate,
            ),
          ),
        );

  final bool isDesk;
  final bool isTablet;
  final SliverChildDelegate delegate;

  @override
  RenderSliverPadding createRenderObject(BuildContext context) {
    return RenderSliverPadding(
      padding: isDesk
          ? const EdgeInsets.all(
              KPadding.kPaddingSize32,
            ).copyWith(left: KPadding.kPaddingSize46)
          : isTablet
              ? const EdgeInsets.all(
                  KPadding.kPaddingSize46,
                )
              : const EdgeInsets.symmetric(
                  vertical: KPadding.kPaddingSize32,
                  horizontal: KPadding.kPaddingSize16,
                ),
      textDirection: Directionality.of(context),
    );
  }
}

class _FooterRightsReservedWidget extends StatelessWidget {
  const _FooterRightsReservedWidget();

  @override
  Widget build(BuildContext context) {
    return Text(
      '${context.l10n.allRightsReserved}  |',
      key: KWidgetkeys.widget.footer.rightReserved,
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
      children: [
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
        _Button(
          widgetKey: KWidgetkeys.widget.footer.discountsButton,
          text: context.l10n.discounts,
          onPressed: () => context.goNamed(KRoute.discounts.name),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        if (Config.isDevelopment)
          _Button(
            widgetKey: KWidgetkeys.widget.footer.informationButton,
            text: context.l10n.information,
            onPressed: () => context.goNamed(KRoute.information.name),
          ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _Button(
          widgetKey: KWidgetkeys.widget.footer.investorsButton,
          text: context.l10n.investors,
          onPressed: () => context.goNamed(KRoute.support.name),
        ),
        if (Config.isDevelopment) ...[
          if (isTablet)
            KSizedBox.kHeightSizedBox8
          else
            KSizedBox.kHeightSizedBox4,
          _Button(
            widgetKey: KWidgetkeys.widget.footer.workButton,
            text: context.l10n.work,
            onPressed: () => context.goNamed(KRoute.work.name),
          ),
          if (isTablet)
            KSizedBox.kHeightSizedBox8
          else
            KSizedBox.kHeightSizedBox4,
          _Button(
            widgetKey: KWidgetkeys.widget.footer.storyButton,
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
      children: [
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
        _Button(
          widgetKey: KWidgetkeys.widget.footer.aboutUsButton,
          text: context.l10n.aboutUs,
          onPressed: () => context.goNamed(KRoute.aboutUs.name),
        ),
        if (isTablet)
          KSizedBox.kHeightSizedBox8
        else
          KSizedBox.kHeightSizedBox4,
        _Button(
          widgetKey: KWidgetkeys.widget.footer.profileButton,
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
        _Button(
          widgetKey: KWidgetkeys.widget.footer.consultationOnlineButton,
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
      children: [
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
      children: [
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
    required this.padding,
    required this.instagramKey,
    required this.linkedInKey,
    required this.facebookKey,
    super.key,
  });

  final bool isDesk;
  final Widget padding;
  final Key instagramKey;
  final Key linkedInKey;
  final Key facebookKey;

  @override
  Widget build(BuildContext context) {
    if (isDesk) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _SocialButton(
            widgetKey: linkedInKey,
            url: KAppText.linkedIn,
            image: KImage.linkedIn(),
          ),
          padding,
          _SocialButton(
            widgetKey: instagramKey,
            url: KAppText.instagram,
            image: KImage.instagram(),
          ),
          padding,
          _SocialButton(
            widgetKey: facebookKey,
            url: KAppText.facebook,
            image: KImage.facebook(),
          ),
        ],
      );
    } else {
      return Wrap(
        children: [
          _SocialButton(
            widgetKey: linkedInKey,
            url: KAppText.linkedIn,
            image: KImage.linkedIn(),
          ),
          padding,
          _SocialButton(
            widgetKey: instagramKey,
            url: KAppText.instagram,
            image: KImage.instagram(),
          ),
          padding,
          _SocialButton(
            widgetKey: facebookKey,
            url: KAppText.facebook,
            image: KImage.facebook(),
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
}
