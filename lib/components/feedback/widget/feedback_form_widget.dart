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
        spacing: KPadding.kPaddingSize46,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  context.l10n.feedbackSubtitle,
                  key: FeedbackKeys.subtitle,
                  style: AppTextStyle.materialThemeBodyLarge,
                ),
                KSizedBox.kHeightSizedBox32,
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: KPadding.kPaddingSize4,
                  runSpacing: KPadding.kPaddingSize8,
                  children: [
                    Text(
                      context.l10n.preferEmail,
                      key: FeedbackKeys.emailText,
                      style:
                          AppTextStyle.materialThemeBodyLargeNeutralVariant60,
                    ),
                    const EmailButtonWidget(
                      key: FeedbackKeys.emailButton,
                      isDesk: true,
                    ),
                  ],
                ),
                KSizedBox.kHeightSizedBox32,
                Text(
                  context.l10n.ourSocialNetworks,
                  key: FeedbackKeys.socialText,
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
            ),
          ),
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
        key: FeedbackKeys.subtitle,
        style: AppTextStyle.materialThemeBodyMedium,
      ),
      KSizedBox.kHeightSizedBox32,
      const FieldWidget(
        isDesk: false,
      ),
      KSizedBox.kHeightSizedBox32,
      Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: KPadding.kPaddingSize4,
        runSpacing: KPadding.kPaddingSize8,
        children: [
          Text(
            context.l10n.preferEmail,
            key: FeedbackKeys.emailText,
            style: AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          ),
          const EmailButtonWidget(
            key: FeedbackKeys.emailButton,
            isDesk: false,
          ),
        ],
      ),
      KSizedBox.kHeightSizedBox32,
      Text(
        context.l10n.ourSocialNetworks,
        key: FeedbackKeys.socialText,
        style: AppTextStyle.materialThemeTitleMedium,
      ),
      KSizedBox.kHeightSizedBox8,
      const SocialMediaLinks(
        isDesk: false,
        instagramKey: FeedbackKeys.instagram,
        linkedInKey: FeedbackKeys.linkedIn,
        facebookKey: FeedbackKeys.facebook,
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
