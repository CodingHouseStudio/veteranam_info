import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget({
    required this.changeMessage,
    required this.hintText,
    required this.hintStyle,
    super.key,
    this.controller,
    this.errorText,
    this.focusNode,
    this.disposeFocusNode,
    this.isDesk,
    this.clearText = false,
    this.hasController = false,
  });
  final void Function(String text) changeMessage;
  final String hintText;
  final TextEditingController? controller;
  final String? errorText;
  final FocusNode? focusNode;
  final bool? disposeFocusNode;
  final TextStyle hintStyle;
  final bool? isDesk;
  final bool clearText;
  final bool hasController;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextFieldWidget(
        widgetKey: KWidgetkeys.widget.input.field,
        hasController: hasController,
        clearText: clearText,
        focusNode: focusNode,
        disposeFocusNode: disposeFocusNode,
        errorText: errorText,
        controller: controller,
        onChanged: changeMessage,
        hintText: hintText,
        minLines: KMinMaxSize.messageMinLines,
        maxLines: KMinMaxSize.messageMaxLines,
        maxLength: KMinMaxSize.messageMaxLength,
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize8),
              child: IconWidget(
                key: KWidgetkeys.widget.input.icon,
                icon: KIcon.mic,
                // background: AppColors.widgetBackground,
                padding: KPadding.kPaddingSize20,
              ),
            ),
            KSizedBox.kHeightSizedBox8,
          ],
        ),
        hintStyle: hintStyle,
        isDesk: isDesk,
      ),
    );
  }
}
