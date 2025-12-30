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
      spacing: KPadding.kPaddingSize100,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: FeedbackKeys.boxSocialMedia,
              context.l10n.ourSocialNetworks,
              style: AppTextStyle.materialThemeTitleMedium,
            ),
            const SocialMediaLinks(
              isDesk: false,
              instagramKey: FeedbackKeys.instagram,
              linkedInKey: FeedbackKeys.linkedIn,
              facebookKey: FeedbackKeys.facebook,
            ),
          ],
        ),
        Expanded(
          child: Column(
            spacing: KPadding.kPaddingSize24,
            children: [
              Text(
                context.l10n.feedbackSent,
                key: FeedbackKeys.boxText,
                style: AppTextStyle.materialThemeDisplaySmall,
              ),
              Row(
                spacing: KPadding.kPaddingSize24,
                children: [
                  DoubleButtonWidget(
                    widgetKey: FeedbackKeys.boxBackButton,
                    text: context.l10n.toTheMainPage,
                    isDesk: true,
                    onPressed: () => _navMain(context),
                    align: Alignment.center,
                    darkMode: true,
                  ),
                  TextButton(
                    key: FeedbackKeys.boxButton,
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
          key: FeedbackKeys.boxText,
          style: AppTextStyle.materialThemeHeadlineSmall,
        ),
        KSizedBox.kHeightSizedBox24,
        DoubleButtonWidget(
          widgetKey: FeedbackKeys.boxBackButton,
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
          key: FeedbackKeys.boxButton,
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
          key: FeedbackKeys.boxSocialMedia,
          style: AppTextStyle.materialThemeTitleMedium,
        ),
        KSizedBox.kHeightSizedBox8,
        const SocialMediaLinks(
          isDesk: false,
          instagramKey: FeedbackKeys.instagram,
          linkedInKey: FeedbackKeys.linkedIn,
          facebookKey: FeedbackKeys.facebook,
        ),
      ],
    );
  }
}

void _navMain(BuildContext context) => context.goNamed(
      Config.isWeb ? KRoute.home.name : KRoute.discounts.name,
    );
