import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ChatBotButton extends StatelessWidget {
  const ChatBotButton({this.onTap, super.key});
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: KBorderRadius.kBorderRadius32,
      child: const IconWidget(
        icon: KIcon.message32,
        padding: KPadding.kPaddingSize20,
        background: AppColors.materialThemeKeyColorsNeutral,
      ),
    );
  }
}
