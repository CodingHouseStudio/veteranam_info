import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget({
    required this.changeMessage,
    required this.isDesk,
    this.hintText,
    this.hintStyle,
    super.key,
    this.controller,
    this.errorText,
    this.focusNode,
    this.disposeFocusNode = true,
    this.labelText,
    this.showErrorText,
    this.errorMaxLines,
  });
  final void Function(String text)? changeMessage;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final bool disposeFocusNode;
  final TextStyle? hintStyle;
  final bool isDesk;
  final bool? showErrorText;
  final int? errorMaxLines;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      widgetKey: KWidgetkeys.widget.messageField.widget,
      focusNode: focusNode,
      disposeFocusNode: disposeFocusNode,
      errorText: errorText,
      controller: controller,
      onChanged: changeMessage,
      hintText: hintText,
      minLines: isDesk ? KMinMaxSize.messageMinLines : null,
      maxLines: isDesk ? KMinMaxSize.messageMaxLines : null,
      maxLength: KMinMaxSize.messageMaxLength,
      labelText: labelText, errorMaxLines: errorMaxLines,
      // suffixIcon: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(KPadding.kPaddingSize8),
      //       child: IconWidget(
      //         key: KWidgetkeys.widget.input.icon,
      //         icon: KIcon.mic,
      //         // background: AppColors.widgetBackground,
      //         padding: KPadding.kPaddingSize20,
      //       ),
      //     ),
      //     KSizedBox.kHeightSizedBox8,
      //   ],
      // ),
      hintStyle: hintStyle,
      isDesk: isDesk,
      showErrorText: showErrorText,
    );
  }
}
