import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({
    required this.messageIcon,
    required this.message,
    super.key,
  });
  final Icon messageIcon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconWidget(
          key: KWidgetkeys.widget.chatInput.icon,
          icon: messageIcon,
          background: AppColors.yellow,
        ),
        KSizedBox.kWidthSizedBox8,
        Container(
          decoration: KWidetTheme.boxDecorChatMessage,
          padding: const EdgeInsets.all(KPadding.kPaddingSize16),
          child: Text(
            message,
            key: KWidgetkeys.widget.chatInput.message,
            style: AppTextStyle.text16,
          ),
        ),
      ],
    );
  }
}
