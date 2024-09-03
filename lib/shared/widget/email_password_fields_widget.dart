import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

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

class _EmailPasswordFieldsWidgetState extends State<EmailPasswordFieldsWidget>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscurePassword = true;
  late FocusNode focusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return
        // GestureDetector(
        //   onTap: () => FocusScope.of(context).unfocus(),
        //   child:
        Column(
      crossAxisAlignment:
          widget.isDesk ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (widget.showPassword)
          Padding(
            padding: const EdgeInsets.only(
                top: KPadding.kPaddingSize16, bottom: KPadding.kPaddingSize16),
            child: ButtonWidget(
              key: KWidgetkeys.widget.emailPasswordFields.buttonHidePassword,
              onPressed: () {
                widget.backPassword();
                focusNode.requestFocus();
              },
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
              // backgroundColor: AppColors.white,
              icon: KIcon.trailing,
              iconRightMerge: KSizedBox.kWidthSizedBox8,
              textStyle: widget.isDesk
                  ? AppTextStyle.materialThemeTitleMedium
                  : AppTextStyle.text16,
            ),
          ),
        //KSizedBox.kHeightSizedBox40,
        // Text(
        //   widget.showPassword ? context.l10n.password : context.l10n.fullEmail,
        //   key: widget.showPassword
        //       ? KWidgetkeys.widget.emailPasswordFields.textPassword
        //       : KWidgetkeys.widget.emailPasswordFields.textEmail,
        //   style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        // ),
        // if (widget.isDesk)
        //   KSizedBox.kHeightSizedBox24
        // else
        //   KSizedBox.kHeightSizedBox8,
        if (widget.showPassword)
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.emailPasswordFields.fieldPassword,
            onChanged: widget.onChangedPassword,
            errorText: widget.errorTextPassword,
            hintText: context.l10n.createSecurePassword,
            isDesk: widget.isDesk,
            controller: passwordController,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: KPadding.kPaddingSize12),
              child: IconButton(
                key: KWidgetkeys.widget.emailPasswordFields.iconHidePassword,
                icon: obscurePassword
                    ? KIcon.eyeOff.copyWith(
                        key: KWidgetkeys.widget.emailPasswordFields.iconEyeOff,
                      )
                    : KIcon.eye.copyWith(
                        key: KWidgetkeys.widget.emailPasswordFields.iconEye,
                      ),
                onPressed: () =>
                    setState(() => obscurePassword = !obscurePassword),
              ),
            ),
            focusNode: focusNode,
            obscureText: obscurePassword,
          )
        else
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.emailPasswordFields.fieldEmail,
            onChanged: widget.onChangedEmail,
            errorText: widget.errorTextEmail,
            hintText: context.l10n.email,
            isDesk: widget.isDesk,
            controller: emailController,
          ),
      ],
      // ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
