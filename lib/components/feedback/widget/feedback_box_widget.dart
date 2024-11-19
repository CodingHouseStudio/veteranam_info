import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FeedbackBoxWidget extends StatelessWidget {
  const FeedbackBoxWidget({
    required this.isDesk,
    required this.sendAgain,
    super.key,
  });
  final bool isDesk;
  final void Function() sendAgain;
  @override
  Widget build(BuildContext context) {
    return isDesk
        ? _FeedbackBoxDesk(sendAgain: sendAgain)
        : _FeedbackBoxMob(sendAgain: sendAgain);
  }
}

class _FeedbackBoxDesk extends StatelessWidget {
  const _FeedbackBoxDesk({
    required this.sendAgain,
  });

  final void Function() sendAgain;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: KWidgetkeys.screen.feedback.boxSocialMedia,
              context.l10n.ourSocialNetworks,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            SocialMediaLinks(
              isDesk: false,
              padding: KSizedBox.kWidthSizedBox24,
              instagramKey: KWidgetkeys.screen.feedback.instagram,
              linkedInKey: KWidgetkeys.screen.feedback.linkedIn,
              facebookKey: KWidgetkeys.screen.feedback.facebook,
            ),
          ],
        ),
        KSizedBox.kWidthSizedBox100,
        Expanded(
          child: Column(
            children: [
              Text(
                context.l10n.feedbackSent,
                key: KWidgetkeys.screen.feedback.boxText,
                style: AppTextStyle.materialThemeDisplaySmall,
              ),
              KSizedBox.kHeightSizedBox24,
              Row(
                children: [
                  DoubleButtonWidget(
                    widgetKey: KWidgetkeys.screen.feedback.boxBackButton,
                    text: context.l10n.toTheMainPage,
                    isDesk: true,
                    onPressed: () => _navMain(context),
                    align: Alignment.center,
                    darkMode: true,
                  ),
                  KSizedBox.kWidthSizedBox24,
                  TextButton(
                    key: KWidgetkeys.screen.feedback.boxButton,
                    onPressed: sendAgain,
                    //() =>
                    //context.goNamed(KRoute.feedback.name),
                    style: KButtonStyles.borderBlackButtonStyle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: KPadding.kPaddingSize12,
                        horizontal: KPadding.kPaddingSize30,
                      ),
                      child: Text(
                        context.l10n.writeMore,
                        style: AppTextStyle.materialThemeTitleMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _FeedbackBoxMob extends StatelessWidget {
  const _FeedbackBoxMob({
    required this.sendAgain,
  });

  final void Function() sendAgain;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          context.l10n.feedbackSent,
          key: KWidgetkeys.screen.feedback.boxText,
          style: AppTextStyle.materialThemeHeadlineSmall,
        ),
        KSizedBox.kHeightSizedBox24,
        DoubleButtonWidget(
          widgetKey: KWidgetkeys.screen.feedback.boxBackButton,
          text: context.l10n.toTheMainPage,
          isDesk: false,
          onPressed: () => _navMain(context),
          darkMode: true,
          mobTextWidth: double.infinity,
          mobVerticalTextPadding: KPadding.kPaddingSize16,
          mobIconPadding: KPadding.kPaddingSize16,
        ),
        KSizedBox.kHeightSizedBox16,
        TextButton(
          key: KWidgetkeys.screen.feedback.boxButton,
          onPressed: sendAgain, //() => context.goNamed(KRoute.feedback.name),
          style: KButtonStyles.borderBlackButtonStyle,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize16,
            ),
            child: Text(
              context.l10n.writeMore,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
          ),
        ),
        KSizedBox.kHeightSizedBox32,
        Text(
          context.l10n.ourSocialNetworks,
          key: KWidgetkeys.screen.feedback.boxSocialMedia,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
        KSizedBox.kHeightSizedBox8,
        SocialMediaLinks(
          isDesk: false,
          padding: KSizedBox.kWidthSizedBox24,
          instagramKey: KWidgetkeys.screen.feedback.instagram,
          linkedInKey: KWidgetkeys.screen.feedback.linkedIn,
          facebookKey: KWidgetkeys.screen.feedback.facebook,
        ),
      ],
    );
  }
}

void _navMain(BuildContext context) => context.goNamed(
      Config.isWeb ? KRoute.home.name : KRoute.discounts.name,
    );
