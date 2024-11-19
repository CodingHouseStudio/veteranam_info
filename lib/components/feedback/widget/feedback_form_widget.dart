import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:veteranam/components/feedback/bloc/feedback_bloc.dart';
import 'package:veteranam/components/feedback/widget/widget.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class FormWidget extends StatelessWidget {
  const FormWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeedbackBloc, FeedbackState>(
      builder: (context, state) {
        if (isDesk) {
          return const _BuildDesktopLayout();
        } else {
          return const _BuildMobileLayout();
        }
      },
    );
  }
}

class _BuildDesktopLayout extends StatelessWidget {
  const _BuildDesktopLayout();

  @override
  Widget build(BuildContext context) {
    final widgets = [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.feedbackSubtitle,
                  key: KWidgetkeys.screen.feedback.subtitle,
                  style: AppTextStyle.materialThemeBodyLarge,
                ),
                KSizedBox.kHeightSizedBox32,
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      context.l10n.preferEmail,
                      key: KWidgetkeys.screen.feedback.emailText,
                      style:
                          AppTextStyle.materialThemeBodyLargeNeutralVariant60,
                    ),
                    KSizedBox.kWidthSizedBox4,
                    EmailButtonWidget(
                      key: KWidgetkeys.screen.feedback.emailButton,
                      isDesk: true,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox32,
                Text(
                  context.l10n.ourSocialNetworks,
                  key: KWidgetkeys.screen.feedback.socialText,
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
            ),
          ),
          KSizedBox.kWidthSizedBox45,
          const Expanded(
            flex: 2,
            child: FieldWidget(
              isDesk: true,
            ),
          ),
        ],
      ),
      KSizedBox.kHeightSizedBox100,
    ];

    return SliverList.builder(
      itemBuilder: (context, index) => widgets.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: widgets.length,
    );
  }
}

class _BuildMobileLayout extends StatelessWidget {
  const _BuildMobileLayout();

  @override
  Widget build(BuildContext context) {
    final widgets = [
      Text(
        context.l10n.feedbackSubtitle,
        key: KWidgetkeys.screen.feedback.subtitle,
        style: AppTextStyle.materialThemeBodyMedium,
      ),
      KSizedBox.kHeightSizedBox32,
      const FieldWidget(
        isDesk: false,
      ),
      KSizedBox.kHeightSizedBox32,
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            context.l10n.preferEmail,
            key: KWidgetkeys.screen.feedback.emailText,
            style: AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
          KSizedBox.kWidthSizedBox4,
          EmailButtonWidget(
            key: KWidgetkeys.screen.feedback.emailButton,
            isDesk: false,
          ),
        ],
      ),
      KSizedBox.kHeightSizedBox32,
      Text(
        context.l10n.ourSocialNetworks,
        key: KWidgetkeys.screen.feedback.socialText,
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
      KSizedBox.kHeightSizedBox32,
    ];

    return SliverList.builder(
      itemBuilder: (context, index) => widgets.elementAt(index),
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: false,
      itemCount: widgets.length,
    );
  }
}
