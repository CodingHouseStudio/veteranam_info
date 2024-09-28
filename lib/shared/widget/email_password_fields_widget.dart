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
    required this.isLogin,
    required this.showErrorText,
    this.bottomTextKey,
    super.key,
    this.errorTextEmail,
    this.errorTextPassword,
    this.bottomError,
  });

  final bool showPassword;
  final bool isDesk;
  final void Function(String) onChangedEmail;
  final void Function(String) onChangedPassword;
  final String? errorTextEmail;
  final bool showErrorText;
  final String? errorTextPassword;
  final String email;
  final void Function() backPassword;
  final bool isLogin;
  final String? bottomError;
  final Key? bottomTextKey;

  @override
  State<EmailPasswordFieldsWidget> createState() =>
      _EmailPasswordFieldsWidgetState();
}

class _EmailPasswordFieldsWidgetState extends State<EmailPasswordFieldsWidget>
    with AutomaticKeepAliveClientMixin {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  bool obscurePassword = true;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFocusNode = FocusNode();
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
              top: KPadding.kPaddingSize16,
              bottom: KPadding.kPaddingSize16,
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: ButtonWidget(
                key: KWidgetkeys.widget.emailPasswordFields.buttonHidePassword,
                onPressed: () {
                  widget.backPassword();
                  passwordFocusNode.requestFocus();
                },
                text: widget.email,
                padding: const EdgeInsets.only(
                  top: KPadding.kPaddingSize8,
                  bottom: KPadding.kPaddingSize8,
                  right: KPadding.kPaddingSize16,
                  left: KPadding.kPaddingSize8,
                ),
                isDesk: widget.isDesk,
                textButtonStyle: KButtonStyles.lightGrayButtonStyle,
                // backgroundColor: AppColors.white,
                icon: KIcon.arrowBackIOS,
                iconRightMerge: KSizedBox.kWidthSizedBox8,
                textStyle: AppTextStyle.materialThemeTitleMedium,
              ),
            ),
          ),
        //KSizedBox.kHeightSizedBox40,
        // Text(
        //   widget.showPassword ? context.l10n.password
        //: context.l10n.fullEmail,
        //   key: widget.showPassword
        //       ? KWidgetkeys.widget.emailPasswordFields.textPassword
        //       : KWidgetkeys.widget.emailPasswordFields.textEmail,
        //   style: widget.isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
        // ),
        // if (widget.isDesk)
        //   KSizedBox.kHeightSizedBox24
        // else
        //   KSizedBox.kHeightSizedBox8,
        if (widget.showPassword) ...[
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.emailPasswordFields.fieldPassword,
            onChanged: widget.onChangedPassword,
            errorText: widget.errorTextPassword,
            hintText: context.l10n.password,
            isDesk: widget.isDesk,
            controller: passwordController,
            suffixIcon: IconButton(
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
            focusNode: passwordFocusNode,
            disposeFocusNode: false,
            obscureText: obscurePassword,
            showErrorText: widget.showErrorText,
          ),
          KSizedBox.kHeightSizedBox8,
          if (widget.isLogin)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: widget.isDesk
                    ? const EdgeInsets.only(
                        left: KPadding.kPaddingSize32,
                      )
                    : const EdgeInsets.only(
                        left: KPadding.kPaddingSize16,
                      ),
                child: TextButton(
                  key: KWidgetkeys.widget.emailPasswordFields.recoveryButton,
                  style: KButtonStyles.withoutStyle,
                  onPressed: null,
                  child: Text(
                    context.l10n.dontRememberPassword,
                    style: AppTextStyle.materialThemeTitleMedium.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
        ] else
          TextFieldWidget(
            widgetKey: KWidgetkeys.widget.emailPasswordFields.fieldEmail,
            onChanged: widget.onChangedEmail,
            errorText: widget.errorTextEmail,
            hintText: context.l10n.email,
            isDesk: widget.isDesk,
            controller: emailController,
            showErrorText: widget.showErrorText,
          ),
        if (widget.bottomError != null) ...[
          KSizedBox.kHeightSizedBox8,
          Text(
            widget.bottomError!,
            key: widget.bottomTextKey,
            style: AppTextStyle.materialThemeBodyMediumError,
          ),
        ],
      ],
      // ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}
