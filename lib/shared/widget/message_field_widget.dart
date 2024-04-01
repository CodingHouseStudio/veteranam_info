import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class MessageFieldWidget extends StatelessWidget {
  const MessageFieldWidget({required this.changeMessage, super.key});
  final void Function(String text) changeMessage;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextFieldWidget(
        widgetKey: KWidgetkeys.inputKeys.field,
        onChanged: changeMessage,
        hintText: KAppText.messageTextFieldHint,
        maxLines: 4,
        fillColor: AppColors.white,
        enabledBorder: KWidetTheme.outlineInputBorder,
        focusedBorder: KWidetTheme.outlineInputBorder,
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
              child: IconWidget(
                key: KWidgetkeys.inputKeys.icon,
                icon: KIcon.mic,
                background: AppColors.widgetBackground,
                padding: KPadding.kPaddingSizeM,
              ),
            ),
          ],
        ),
        contentPadding: const EdgeInsets.all(
          KPadding.kPaddingSizeML,
        ),
      ),
    );
  }
}
