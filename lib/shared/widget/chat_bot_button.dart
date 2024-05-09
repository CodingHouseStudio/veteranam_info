import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ChatBotButton extends StatelessWidget {
  const ChatBotButton({this.onTap, super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: KBorderRadius.kBorderRadius32,
      child: IconWidget(
        icon: KIcon.message.setIconSize(KSize.kPixel32),
        padding: KPadding.kPaddingSize20,
        background: Theme.of(context).colorScheme.secondaryContainer,
      ),
    );
  }
}
