import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
  late bool termsAndConditionsAgree;
  @override
  void initState() {
    termsAndConditionsAgree = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      key: ConfirmPublishDiscountKeys.dialog,
      constraints: const BoxConstraints(maxWidth: KMinMaxSize.minHeight640),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Padding(
            padding: const EdgeInsets.all(KPadding.kPaddingSize8),
            child: IconButton(
              key: ConfirmPublishDiscountKeys.closeIcon,
              style: KButtonStyles.circularButtonStyle,
              onPressed: context.popDialog,
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
                    key: ConfirmPublishDiscountKeys.title,
                    style: widget.isDesk
                        ? AppTextStyle.materialThemeHeadlineLarge
                        : AppTextStyle.materialThemeHeadlineSmall,
                  ),
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox16
                else
                  KSizedBox.kHeightSizedBox8,
                // Android not support RichText Widget
                Text.rich(
                  key: ConfirmPublishDiscountKeys.description,
                  TextSpan(
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
                SizedBox(
                  width: double.infinity,
                  child: CheckPointWidget(
                    key: ConfirmPublishDiscountKeys.termsAndConditionsSwitcher,
                    onChanged: () => setState(() {
                      termsAndConditionsAgree = !termsAndConditionsAgree;
                    }),
                    isCheck: termsAndConditionsAgree,
                    text: null,
                    isDesk: widget.isDesk,
                    textWidget: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runSpacing: KPadding.kPaddingSize2,
                      spacing: KPadding.kPaddingSize8,
                      children: [
                        Text(
                          context.l10n.iAgreeWith,
                          key:
                              ConfirmPublishDiscountKeys.termsAndConditionsText,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: widget.isDesk
                              ? AppTextStyle.materialThemeBodyLarge
                              : AppTextStyle.materialThemeBodyMedium,
                        ),
                        InkWell(
                          key: ConfirmPublishDiscountKeys
                              .termsAndConditionsButton,
                          onTap: () =>
                              context.goNamed(KRoute.termsAndConditions.name),
                          overlayColor: const WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          hoverColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: KPadding.kPaddingSize8,
                            ),
                            child: Text(
                              context.l10n.termsAndConditions,
                              style: widget.isDesk
                                  ? AppTextStyle.materialThemeBodyLargeBold
                                  : AppTextStyle.materialThemeBodyMediumBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.isDesk)
                  KSizedBox.kHeightSizedBox32
                else
                  KSizedBox.kHeightSizedBox24,
                // if (widget.isDesk)
                Wrap(
                  spacing: KPadding.kPaddingSize24,
                  runSpacing: KPadding.kPaddingSize16,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: buttonList,
                ),
                // else
                //   Column(
                //     children: [
                //       confirmButton(context),
                //       KSizedBox.kHeightSizedBox16,
                //       unconfirmButton(context),
                //     ],
                //   ),
                if (!widget.isDesk) KSizedBox.kHeightSizedBox16,
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get buttonList {
    final buttons = [
      unconfirmButton,
      // KSizedBox.kWidthSizedBox24,
      confirmButton,
    ];
    if (widget.isDesk) {
      return buttons;
    } else {
      return buttons.reversed.toList();
    }
  }

  DoubleButtonWidget get confirmButton {
    return DoubleButtonWidget(
      widgetKey: ConfirmPublishDiscountKeys.sendButton,
      text: '${context.l10n.send} ${context.l10n.verification}',
      // color: background,
      isDesk: widget.isDesk,
      deskPadding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize30,
      ),
      align: widget.isDesk ? null : Alignment.center,
      mobTextWidth: double.infinity,
      mobVerticalTextPadding: KPadding.kPaddingSize16,
      mobIconPadding: KPadding.kPaddingSize16,
      color: termsAndConditionsAgree
          ? null
          : AppColors.materialThemeRefSecondarySecondary98,
      textColor: termsAndConditionsAgree
          ? null
          : AppColors.materialThemeRefSecondarySecondary50,
      onPressed: termsAndConditionsAgree
          ? () {
              widget.onPressed!();
              context.popDialog();
            }
          : null,
      hasAlign: !widget.isDesk,
    );
  }

  Widget get unconfirmButton {
    return SecondaryButtonWidget(
      widgetKey: ConfirmPublishDiscountKeys.continueButton,
      align: widget.isDesk ? null : Alignment.center,
      onPressed: () => context.popDialog(),
      padding: const EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize12,
        horizontal: KPadding.kPaddingSize12,
      ),
      expanded: !widget.isDesk,
      isDesk: widget.isDesk,
      text: context.l10n.continueWorking,
      hasAlign: !widget.isDesk,
    );
  }
}
