import 'dart:async' show Timer;

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/components/components.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class UserEmailDialog extends StatefulWidget {
  const UserEmailDialog({
    required this.onChanged,
    required this.isDesk,
    required this.sendOnPressed,
    // required this.closeOnPressed,
    required this.userEmailEnum,
    required this.emailCloseDelay,
    super.key,
  });
  final void Function(String) onChanged;
  final bool isDesk;
  final void Function() sendOnPressed;
  // final void Function() closeOnPressed;
  final UserEmailEnum userEmailEnum;
  final int emailCloseDelay;

  @override
  State<UserEmailDialog> createState() => _UserEmailDialogState();
}

class _UserEmailDialogState extends State<UserEmailDialog> {
  late bool _isCloseEnabled;
  Timer? _timer;
  @override
  void initState() {
    if (widget.userEmailEnum.closeEnable) {
      _isCloseEnabled = true;
    } else {
      _isCloseEnabled = false;
      _timer = Timer(
          Duration(
            seconds: widget.emailCloseDelay,
          ), () {
        setState(() {
          _isCloseEnabled = true;
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DiscountUserEmailFormBloc, DiscountUserEmailFormState>(
      listener: (context, state) {
        if (state.formState == EmailEnum.success
            // ||
            //     state.formState == EmailEnum.close
            ) {
          // if (state.formState == EmailEnum.close) {
          //   FirebaseAnalytics.instance.logEvent(
          //     name: 'discount_email_abandon',
          //   );
          // } else {
          //   FirebaseAnalytics.instance.logEvent(
          //     name: 'discount_email_acquire',
          //     parameters: {
          //       'isValid': '${state.email.isValid}',
          //     },
          //   );
          // }
          context.pop<bool>(true);
        }
      },
      builder: (context, state) => DecoratedBox(
        decoration: KWidgetTheme.boxDecorationDiscountContainer,
        child: Padding(
          padding: widget.isDesk
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
                  onPressed:
                      _isCloseEnabled ? () => context.pop<bool>(false) : null,
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
                    padding: widget.isDesk
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
                          style: widget.isDesk
                              ? AppTextStyle.materialThemeHeadlineLarge
                              : AppTextStyle.materialThemeHeadlineMedium,
                        ),
                        if (widget.isDesk)
                          KSizedBox.kHeightSizedBox16
                        else
                          KSizedBox.kHeightSizedBox8,
                        if (widget.isDesk)
                          Text(
                            key: KWidgetkeys
                                .widget.userEmailDialog.emailDialogSubtitle,
                            _text(context),
                            style: widget.isDesk
                                ? AppTextStyle.materialThemeBodyLarge
                                : AppTextStyle.materialThemeBodyMedium,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              if (!widget.isDesk)
                Text(
                  key: KWidgetkeys.widget.userEmailDialog.emailDialogSubtitle,
                  _text(context),
                  style: widget.isDesk
                      ? AppTextStyle.materialThemeBodyLarge
                      : AppTextStyle.materialThemeBodyMedium,
                ),
              if (widget.isDesk)
                KSizedBox.kHeightSizedBox32
              else
                KSizedBox.kHeightSizedBox24,
              if (widget.isDesk)
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

  String _text(BuildContext context) {
    return '${context.l10n.aboutNewDiscountsSubtitle}'
        '${Config.isWeb ? ')' : '😀'}';
  }

  Widget field(
    BuildContext context,
  ) =>
      TextFieldWidget(
        widgetKey: KWidgetkeys.widget.userEmailDialog.field,
        onChanged: widget.onChanged,
        isRequired: true,
        isDesk: widget.isDesk,
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
        isDesk: widget.isDesk,
        onPressed: context.read<DiscountUserEmailFormBloc>().state.formState ==
                EmailEnum.success
            ? null
            : widget.sendOnPressed,
        widgetKey: KWidgetkeys.widget.userEmailDialog.button,
        darkMode: true,
        hasAlign: widget.isDesk,
        mobTextWidth: double.infinity,
        mobVerticalTextPadding: KPadding.kPaddingSize16,
        mobIconPadding: KPadding.kPaddingSize16,
      );

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
