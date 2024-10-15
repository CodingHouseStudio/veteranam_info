import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class PasswordFieldWidget extends StatefulWidget {
  const PasswordFieldWidget({
    required this.onChanged,
    required this.isDesk,
    required this.widgetKey,
    required this.labelText,
    super.key,
    this.errorText,
    this.controller,
    this.focusNode,
    this.showErrorText,
    this.disposeFocusNode,
    this.enabled,
  });
  final void Function(String) onChanged;
  final String? errorText;
  final bool isDesk;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? showErrorText;
  final bool? disposeFocusNode;
  final Key widgetKey;
  final String labelText;
  final bool? enabled;

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  late bool obscurePassword;

  @override
  void initState() {
    obscurePassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      widgetKey: widget.widgetKey,
      onChanged: widget.onChanged,
      errorText: widget.errorText,
      isRequired: true,
      labelText: widget.labelText,
      isDesk: widget.isDesk,
      enabled: widget.enabled,
      controller: widget.controller,
      suffixIcon: IconButton(
        key: KWidgetkeys.widget.emailPasswordFields.iconHidePassword,
        icon: obscurePassword
            ? KIcon.eyeOff.copyWith(
                key: KWidgetkeys.widget.emailPasswordFields.iconEyeOff,
              )
            : KIcon.eye.copyWith(
                key: KWidgetkeys.widget.emailPasswordFields.iconEye,
              ),
        onPressed: () => setState(() => obscurePassword = !obscurePassword),
      ),
      focusNode: widget.focusNode,
      disposeFocusNode: widget.disposeFocusNode ?? true,
      obscureText: obscurePassword,
      showErrorText: widget.showErrorText,
    );
  }
}
