import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
          background: AppColors.materialThemeKeyColorsNeutral,
        ),
        KSizedBox.kWidthSizedBox8,
        if (message != null)
          Container(
            decoration: KWidgetTheme.boxDecorChatMessage,
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Text(
              message!,
              key: KWidgetkeys.widget.chatInput.message,
              style: AppTextStyle.text16,
            ),
          )
        else
          Container(
            decoration: KWidgetTheme.boxDecorChatMessage,
            padding: const EdgeInsets.all(KPadding.kPaddingSize16),
            child: Row(
              children: [
                Container(
                  height: KSize.kPixel8,
                  width: KSize.kPixel8,
                  decoration: KWidgetTheme.boxDecorationGrayCircular,
                ),
                KSizedBox.kWidthSizedBox8,
                Container(
                  height: KSize.kPixel8,
                  width: KSize.kPixel8,
                  decoration: KWidgetTheme.boxDecorationGrayCircular,
                ),
                KSizedBox.kWidthSizedBox8,
                Container(
                  height: KSize.kPixel8,
                  width: KSize.kPixel8,
                  decoration: KWidgetTheme.boxDecorationGrayCircular,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
