import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

class NotificationLinkWidget extends StatelessWidget {
  const NotificationLinkWidget({
    required this.onChanged,
    required this.isDesk,
    required this.title,
    required this.sendOnPressed,
    super.key,
  });
  final void Function(String) onChanged;
  final bool isDesk;
  final String title;
  final void Function() sendOnPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
              key: KWidgetkeys.widget.notificationLink.text,
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
                children: [
                  Expanded(
                    child: field(context),
                  ),
                  KSizedBox.kWidthSizedBox24,
                  button(context),
                ],
              )
            else ...[
              field(context),
              KSizedBox.kHeightSizedBox16,
              button(context),
            ],
          ],
        ),
      ),
    );
  }

  Widget field(
    BuildContext context,
  ) =>
      TextFieldWidget(
        widgetKey: KWidgetkeys.widget.notificationLink.field,
        onChanged: onChanged,
        isDesk: isDesk,
        suffixIcon: KIcon.link,
        labelText: context.l10n.link,
      );
  Widget button(BuildContext context) => DoubleButtonWidget(
        text: context.l10n.send,
        isDesk: isDesk,
        onPressed: sendOnPressed,
        widgetKey: KWidgetkeys.widget.notificationLink.button,
        hasAlign: isDesk,
        mobTextWidth: double.infinity,
      );
}
