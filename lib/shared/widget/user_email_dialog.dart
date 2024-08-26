import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
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
    return BlocConsumer<DiscountUserEmailFormBloc, DiscountUserEmailFormState>(
      listener: (context, state) {
        if (state.formState == EmailEnum.success) {
          context.pop();
        }
      },
      builder: (context, state) => DecoratedBox(
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
                  padding: 0,
                  color: AppColors.materialThemeKeyColorsNeutralVariant,
                  background: AppColors.materialThemeWhite,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconWidget(
                    icon: KIcon.arrowDownRight,
                    padding: isDesk
                        ? KPadding.kPaddingSize20
                        : KPadding.kPaddingSize8,
                  ),
                  KSizedBox.kWidthSizedBox16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key: KWidgetkeys
                              .widget.userEmailDialog.emailDialogTitle,
                          context.l10n.aboutNewDiscounts,
                          style: isDesk
                              ? AppTextStyle.materialThemeHeadlineLarge
                              : AppTextStyle.materialThemeHeadlineMedium,
                        ),
                        if (isDesk)
                          KSizedBox.kHeightSizedBox16
                        else
                          KSizedBox.kHeightSizedBox8,
                        if (isDesk)
                          Text(
                            key: KWidgetkeys
                                .widget.userEmailDialog.emailDialogSubtitle,
                            KTest.testIsWeb
                                ? '${context.l10n.aboutNewDiscountsSubtitle})'
                                : '${context.l10n.aboutNewDiscountsSubtitle} 😀',
                            style: isDesk
                                ? AppTextStyle.materialThemeBodyLarge
                                : AppTextStyle.materialThemeBodyMedium,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (!isDesk)
                Text(
                  key: KWidgetkeys.widget.userEmailDialog.emailDialogSubtitle,
                  KTest.testIsWeb
                      ? '${context.l10n.aboutNewDiscountsSubtitle})'
                      : '${context.l10n.aboutNewDiscountsSubtitle} 😀',
                  style: isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
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
        errorText: context
            .read<DiscountUserEmailFormBloc>()
            .state
            .email
            .error
            .value(context),
        showErrorText:
            context.read<DiscountUserEmailFormBloc>().state.formState ==
                EmailEnum.invalidData,
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
        mobVerticalTextPadding: KPadding.kPaddingSize16,
        mobIconPadding: KPadding.kPaddingSize16,
      );
}
