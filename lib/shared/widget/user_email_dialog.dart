import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared.dart';

class UserEmailDialog extends StatelessWidget {
  const UserEmailDialog({
    required this.onChanged,
    required this.isDesk,
    required this.sendOnPressed,
    required this.closeOnPressed,
    super.key,
  });
  final void Function(String) onChanged;
  final bool isDesk;
  final void Function() sendOnPressed;
  final void Function() closeOnPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: KWidgetTheme.boxDecorationDiscountContainer,
      child: Padding(
        padding: isDesk
            ? const EdgeInsets.only(
                top: KPadding.kPaddingSize8,
                right: KPadding.kPaddingSize40,
                left: KPadding.kPaddingSize40,
                bottom: KPadding.kPaddingSize40,
              )
            : const EdgeInsets.only(
                top: KPadding.kPaddingSize8,
                right: KPadding.kPaddingSize16,
                left: KPadding.kPaddingSize16,
                bottom: KPadding.kPaddingSize32,
              ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButtonWidget(
                icon: KIcon.close,
                key: KWidgetkeys.widget.userEmailDialog.icon,
                onPressed: closeOnPressed,
                background: AppColors.materialThemeWhite,
              ),
            ),
            Row(
              children: [
                IconWidget(
                  icon: KIcon.arrowDownRight,
                  padding:
                      isDesk ? KPadding.kPaddingSize20 : KPadding.kPaddingSize8,
                ),
                KSizedBox.kWidthSizedBox16,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        key:
                            KWidgetkeys.widget.userEmailDialog.emailDialogTitle,
                        context.l10n.aboutNewDiscounts,
                        style: isDesk
                            ? AppTextStyle.materialThemeHeadlineLarge
                            : AppTextStyle.materialThemeHeadlineMedium,
                      ),
                      if (isDesk)
                        KSizedBox.kHeightSizedBox16
                      else
                        KSizedBox.kHeightSizedBox8,
                      Text(
                        key: KWidgetkeys
                            .widget.userEmailDialog.emailDialogSubtitle,
                        context.l10n.aboutNewDiscountsSubtitle,
                        style: isDesk
                            ? AppTextStyle.materialThemeBodyLarge
                            : AppTextStyle.materialThemeBodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isDesk)
              KSizedBox.kHeightSizedBox32
            else
              KSizedBox.kHeightSizedBox24,
            if (isDesk)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: field(context),
                  ),
                  KSizedBox.kWidthSizedBox16,
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
        widgetKey: KWidgetkeys.widget.userEmailDialog.field,
        onChanged: onChanged,
        isDesk: isDesk,
        labelText: context.l10n.email,
      );
  Widget button(BuildContext context) => DoubleButtonWidget(
        text: context.l10n.send,
        isDesk: isDesk,
        onPressed: sendOnPressed,
        widgetKey: KWidgetkeys.widget.userEmailDialog.button,
        color: AppColors.materialThemeBlack,
        textColor: AppColors.materialThemeWhite,
        hasAlign: isDesk,
        mobTextWidth: double.infinity,
      );
}
