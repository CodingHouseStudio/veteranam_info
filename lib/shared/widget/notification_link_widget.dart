import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class NotificationLinkWidget extends StatelessWidget {
  const NotificationLinkWidget({
    required this.onChanged,
    required this.isDesk,
    required this.title,
    required this.sendOnPressed,
    required this.fieldController,
    // required this.filedErrorText,
    required this.enabled,
    required this.showThankText,
    // required this.showErrorText,
    super.key,
  });
  final void Function(String) onChanged;
  final bool isDesk;
  final String title;
  final void Function() sendOnPressed;
  final TextEditingController fieldController;
  // final String? filedErrorText;
  final bool enabled;
  final bool showThankText;
  // final bool showErrorText;

  @override
  Widget build(BuildContext context) {
    if (!showThankText && enabled) {
      return Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize48),
        child: DecoratedBox(
          decoration: KWidgetTheme.boxDecorationDiscountContainer,
          child: Padding(
            padding: EdgeInsets.all(
              isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  key: NotificationLinkKeys.text,
                  style: isDesk
                      ? AppTextStyle.materialThemeTitleLarge
                      : AppTextStyle.materialThemeTitleMedium,
                ),
                if (isDesk)
                  KSizedBox.kHeightSizedBox32
                else
                  KSizedBox.kHeightSizedBox24,
                if (isDesk)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: KPadding.kPaddingSize24,
                    children: [
                      Expanded(
                        child: field(context),
                      ),
                      button(context),
                    ],
                  )
                else ...[
                  field(context),
                  KSizedBox.kHeightSizedBox16,
                  button(context),
                ],
                // if (showThankText) ...[
                //   KSizedBox.kHeightSizedBox8,
                //   Text(
                //     context.l10n.linkThankMessage,
                //     style: AppTextStyle.
                // materialThemeBodyMediumNeutralVariant60,
                //   ),
                // ],
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: KPadding.kPaddingSize8),
        child: Text(
          showThankText
              ? context.l10n.linkThankMessage
              : context.l10n.linkLimitMessage,
          key: NotificationLinkKeys.thankText,
          style: AppTextStyle.materialThemeBodyMediumNeutralVariant35,
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  Widget field(
    BuildContext context,
  ) =>
      TextFieldWidget(
        widgetKey: NotificationLinkKeys.field,
        onChanged: onChanged,
        isDesk: isDesk,
        suffixIcon: KIcon.link,
        labelText: context.l10n.link,
        controller: fieldController,
        // errorText: filedErrorText,
        // showErrorText: showErrorText,
      );
  Widget button(BuildContext context) => DoubleButtonWidget(
        text: context.l10n.send,
        isDesk: isDesk,
        onPressed: sendOnPressed,
        widgetKey: NotificationLinkKeys.button,
        hasAlign: isDesk,
        mobTextWidth: double.infinity,
      );
}
