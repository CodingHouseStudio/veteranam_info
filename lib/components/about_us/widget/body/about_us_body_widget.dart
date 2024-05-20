import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class AboutUsBodyWidget extends StatelessWidget {
  const AboutUsBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox30,
        RateWidget(
          isDesk: isDesk,
          onRatingUpdate: null,
        ),
        const ChatInputWidget(
          messageIcon: KIcon.message,
          message: KMockText.nickname,
        ),
        KSizedBox.kHeightSizedBox30,
        const ChatBotButton(),
        KSizedBox.kHeightSizedBox30,
        const ChatInputWidget(
          messageIcon: KIcon.person,
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
