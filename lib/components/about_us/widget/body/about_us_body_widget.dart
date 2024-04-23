import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class AboutUsBodyWidget extends StatelessWidget {
  const AboutUsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        CheckPointWidget(
          onChanged: ({required isCheck}) {},
        ),
        KSizedBox.kHeightSizedBox30,
        Row(
          children: [
            const ChatInputWidget(
              messageIcon: KIcon.message,
              message: KMockText.nickname,
            ),
            KSizedBox.kWidthSizedBox24,
            ChatBotButton(
              onTap: () {},
            ),
          ],
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
