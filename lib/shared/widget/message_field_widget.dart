import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget({required this.changeMessage, super.key});
  final void Function(String text) changeMessage;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextFieldWidget(
        widgetKey: KWidgetkeys.widget.input.field,
        onChanged: changeMessage,
        hintText: KAppText.messageTextFieldHint,
        maxLines: 4,
        fillColor: AppColors.white,
        enabledBorder: KBorder.outlineInputLightGray,
        focusedBorder: KBorder.outlineInputLightGray,
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSize10),
              child: IconWidget(
                key: KWidgetkeys.widget.input.icon,
                icon: KIcon.mic,
                background: AppColors.widgetBackground,
                padding: KPadding.kPaddingSize20,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(
          KPadding.kPaddingSize32,
        ),
      ),
    );
  }
}
