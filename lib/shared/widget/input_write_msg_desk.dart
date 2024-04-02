import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class InputWriteMsgDesk extends StatelessWidget {
  const InputWriteMsgDesk({required this.changeMessage, super.key});

  final void Function(String text) changeMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1248,
      height: 254,
      child: IntrinsicHeight(
        child: TextFieldWidget(
          widgetKey: KWidgetkeys.inputKeysDesk.field,
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
                padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
                child: IconWidget(
                  key: KWidgetkeys.inputKeysDesk.icon,
                  icon: KIcon.mic,
                  background: AppColors.widgetBackground,
                  padding: KPadding.kPaddingSizeM,
                ),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(KPadding.kPaddingSizeML),
        ),
      ),
    );
  }
}
