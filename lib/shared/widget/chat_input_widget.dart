import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ChatInputWidget extends StatelessWidget {
  const ChatInputWidget({
    required this.messageIcon,
    this.message,
    super.key,
  });
  final Icon messageIcon;
  final String? message;

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
        if (message != null)
          Container(
            decoration: KWidetTheme.boxDecorChatMessage,
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Text(
              message!,
              key: KWidgetkeys.widget.chatInput.message,
              style: AppTextStyle.text16,
            ),
          )
        else
          Container(
            decoration: KWidetTheme.boxDecorChatMessage,
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  decoration: KWidetTheme.boxDecorationCircular,
                ),
                KSizedBox.kWidthSizedBox8,
                Container(
                  height: 8,
                  width: 8,
                  decoration: KWidetTheme.boxDecorationCircular
                      .copyWith(color: AppColors.blackWhite),
                ),
                KSizedBox.kWidthSizedBox8,
                Container(
                  height: 8,
                  width: 8,
                  decoration: KWidetTheme.boxDecorationCircular
                      .copyWith(color: AppColors.grey),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
