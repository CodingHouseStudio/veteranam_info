import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
    // this.disposeFocusNode = true,
    this.labelText,
    this.showErrorText,
    this.errorMaxLines,
    this.description,
    this.maxLength,
    this.isRequired,
  });
  final void Function(String text)? changeMessage;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  // final bool disposeFocusNode;
  final TextStyle? hintStyle;
  final bool isDesk;
  final bool? showErrorText;
  final int? errorMaxLines;
  final String? description;
  final int? maxLength;
  final bool? isRequired;

  @override
  Widget build(BuildContext context) {
    return TextFieldWidget(
      widgetKey: MessageFieldKeys.widget,
      focusNode: focusNode, isRequired: isRequired,
      // disposeFocusNode: disposeFocusNode,
      errorText: errorText,
      controller: controller,
      onChanged: changeMessage,
      hintText: hintText,
      minLines: isDesk ? KMinMaxSize.messageMinLines : null,
      maxLines: isDesk ? KMinMaxSize.messageMaxLines : null,
      maxLength: maxLength ?? KMinMaxSize.messageMaxLength,
      labelText: labelText, errorMaxLines: errorMaxLines,
      description: description,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
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
