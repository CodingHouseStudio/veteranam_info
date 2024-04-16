import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class EmailPasswordFieldsWidget extends StatefulWidget {
  const EmailPasswordFieldsWidget({
    required this.showPassword,
    required this.isDesk,
    required this.onChangedEmail,
    required this.onChangedPassword,
    required this.email,
    required this.backPassword,
    super.key,
    this.errorTextEmail,
    this.errorTextPassword,
  });
  final bool showPassword;
  final bool isDesk;
  final void Function(String) onChangedEmail;
  final void Function(String) onChangedPassword;
  final String? errorTextEmail;
  final String? errorTextPassword;
  final String email;
  final void Function() backPassword;

  @override
  State<EmailPasswordFieldsWidget> createState() =>
      _EmailPasswordFieldsWidgetState();
}

class _EmailPasswordFieldsWidgetState extends State<EmailPasswordFieldsWidget> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isDesk ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (widget.showPassword)
          Padding(
            padding: const EdgeInsets.only(top: KPadding.kPaddingSize16),
            child: ButtonWidget(
              onPressed: widget.backPassword,
              text: widget.email,
              padding: widget.isDesk
                  ? const EdgeInsets.symmetric(
                      vertical: KPadding.kPaddingSize16,
                      horizontal: KPadding.kPaddingSize32,
                    )
                  : const EdgeInsets.all(
                      KPadding.kPaddingSize16,
                    ),
              isDesk: widget.isDesk,
              backgroundColor: AppColors.white,
              icon: KIcon.trailing,
              iconRightMerge: KSizedBox.kWidthSizedBox8,
              textStyle:
                  widget.isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
          ),
        KSizedBox.kHeightSizedBox40,
        Text(
          widget.showPassword ? context.l10n.password : context.l10n.fullEmail,
          key: widget.showPassword
              ? KWidgetkeys.widget.emailPasswordFields.textPassword
              : KWidgetkeys.widget.emailPasswordFields.textEmail,
          style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        ),
        if (widget.isDesk)
          KSizedBox.kHeightSizedBox24
        else
          KSizedBox.kHeightSizedBox8,
        if (widget.showPassword)
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.emailPasswordFields.fieldPassword,
            onChanged: widget.onChangedPassword,
            errorText: widget.errorTextPassword,
            hintText: context.l10n.createSecurePassword,
            isDesk: widget.isDesk,
            controller: passwordController,
          )
        else
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.emailPasswordFields.fieldEmail,
            onChanged: widget.onChangedEmail,
            errorText: widget.errorTextEmail,
            hintText: context.l10n.writeYourEmail,
            isDesk: widget.isDesk,
            controller: emailController,
          ),
      ],
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
