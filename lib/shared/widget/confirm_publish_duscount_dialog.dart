import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class ConfirmPublishDiscountDialog extends StatefulWidget {
  const ConfirmPublishDiscountDialog({
    required this.isDesk,
    this.onPressed,
    super.key,
  });
  final bool isDesk;
  final void Function()? onPressed;

  @override
  State<ConfirmPublishDiscountDialog> createState() =>
      _ConfirmPublishDiscountDialogState();
}

class _ConfirmPublishDiscountDialogState
    extends State<ConfirmPublishDiscountDialog> {
  late bool privacyPolicyAgree;
  @override
  void initState() {
    privacyPolicyAgree = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: KMinMaxSize.minHeight640),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize8),
            child: IconButton(
              style: KButtonStyles.circularButtonStyle,
              onPressed: context.pop,
              icon: KIcon.close,
            ),
          ),
          Padding(
            padding: widget.isDesk
                ? const EdgeInsets.symmetric(
                    horizontal: KPadding.kPaddingSize40,
                    vertical: KPadding.kPaddingSize32,
                  )
                : const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(right: KPadding.kPaddingSize24),
                  child: Text(
                    '${context.l10n.send} ${context.l10n.verification}?',
                    key: KWidgetkeys.widget.dialogs.profileTitle,
                    style: widget.isDesk
                        ? AppTextStyle.materialThemeHeadlineLarge
                        : AppTextStyle.materialThemeHeadlineSmall,
                  ),
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox8,
                RichText(
                  text: TextSpan(
                    style: widget.isDesk
                        ? AppTextStyle.materialThemeBodyLarge
                        : AppTextStyle.materialThemeBodyMedium,
                    children: [
                      TextSpan(
                        text: context.l10n.publishVerificationSubtitleFirst,
                      ),
                      TextSpan(
                        text: ' «${context.l10n.send}'
                            ' ${context.l10n.verification}», ',
                        style: widget.isDesk
                            ? AppTextStyle.materialThemeBodyLargeBold
                            : AppTextStyle.materialThemeBodyMediumBold,
                      ),
                      TextSpan(
                        text: context.l10n.publishVerificationSubtitleSecond,
                      ),
                      TextSpan(
                        text: ' ${KAppText.email} ',
                        style: widget.isDesk
                            ? AppTextStyle.materialThemeBodyLargeBold
                            : AppTextStyle.materialThemeBodyMediumBold,
                        mouseCursor: SystemMouseCursors.click,
                        recognizer: TapGestureRecognizer()
                          ..onTap = context.copyEmail,
                      ),
                      TextSpan(
                        text: context.l10n.publishVerificationSubtitleThird,
                      ),
                    ],
                  ),
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox24,
                Row(
                  children: [
                    Expanded(
                      child: CheckPointWidget(
                        onChanged: () => setState(() {
                          privacyPolicyAgree = !privacyPolicyAgree;
                        }),
                        isCheck: privacyPolicyAgree,
                        text: context.l10n.agreeTermsConditions,
                        isDesk: widget.isDesk,
                        textWidget: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runSpacing: KPadding.kPaddingSize2,
                          spacing: KPadding.kPaddingSize8,
                          children: [
                            Text(
                              context.l10n.agreeTermsConditions,
                              key: KWidgetkeys.widget.checkPoint.text,
                              maxLines: 3,
                              style: widget.isDesk
                                  ? AppTextStyle.materialThemeBodyLarge
                                  : AppTextStyle.materialThemeBodyMedium,
                            ),
                            InkWell(
                              onTap: () =>
                                  context.goNamed(KRoute.privacyPolicy.name),
                              overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent,
                              ),
                              hoverColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              child: Text(
                                context.l10n.privacyPolicy,
                                style: widget.isDesk
                                    ? AppTextStyle.materialThemeBodyLargeBold
                                    : AppTextStyle.materialThemeBodyMediumBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox32
                else
                  KSizedBox.kHeightSizedBox24,
                if (widget.isDesk)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      confirmButton(context),
                      KSizedBox.kWidthSizedBox24,
                      unconfirmButton(context),
                    ],
                  )
                else
                  Column(
                    children: [
                      confirmButton(context),
                      KSizedBox.kHeightSizedBox16,
                      unconfirmButton(context),
                    ],
                  ),
                if (!widget.isDesk) KSizedBox.kHeightSizedBox16,
              ],
            ),
          ),
        ],
      ),
    );
  }

  DoubleButtonWidget confirmButton(BuildContext context) {
    return DoubleButtonWidget(
      widgetKey: KWidgetkeys.widget.dialogs.confirmButton,
      text: '${context.l10n.send}${context.l10n.verification}',
      // color: background,
      isDesk: widget.isDesk,
      deskPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize30,
      ),
      mobTextWidth: double.infinity,
      mobVerticalTextPadding: KPadding.kPaddingSize16,
      mobIconPadding: KPadding.kPaddingSize16,
      color: privacyPolicyAgree
          ? null
          : AppColors.materialThemeRefSecondarySecondary98,
      textColor: privacyPolicyAgree
          ? null
          : AppColors.materialThemeRefSecondarySecondary50,
      onPressed: privacyPolicyAgree ? widget.onPressed : null,
    );
  }

  Widget unconfirmButton(BuildContext context) {
    return SecondaryButtonWidget(
      widgetKey: KWidgetkeys.widget.dialogs.unconfirmButton,
      onPressed: () => context.pop(),
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize12,
      ),
      expanded: !widget.isDesk,
      isDesk: widget.isDesk,
      text: context.l10n.continueWorking,
    );
  }
}
