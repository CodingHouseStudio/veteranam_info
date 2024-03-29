import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({required this.changeMessage, super.key});
  final void Function(String text) changeMessage;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: TextFieldWidget(
        widgetKey: KWidgetkeys.inputKeys.field,
        onChanged: changeMessage,
        hintText: KAppText.messageTextFieldHint,
        maxLines: 4,
        fillColor: KColorTheme.white,
        enabledBorder: KBorder.outlineInput,
        focusedBorder: KBorder.outlineInput,
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
              child: IconWidget(
                key: KWidgetkeys.inputKeys.icon,
                icon: KIcon.mic,
                background: KColorTheme.widgetBackground,
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
