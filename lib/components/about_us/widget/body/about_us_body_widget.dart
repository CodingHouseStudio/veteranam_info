import 'package:flutter/material.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class AboutUsBodyWidget extends StatefulWidget {
  const AboutUsBodyWidget({super.key});

  @override
  State<AboutUsBodyWidget> createState() => _AboutUsBodyWidgetState();
}

class _AboutUsBodyWidgetState extends State<AboutUsBodyWidget> {
  late bool switcherIsSelected;
  @override
  void initState() {
    switcherIsSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
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
        SwitchOfflineWidget(
          isSelected: switcherIsSelected,
          onChanged: () =>
              setState(() => switcherIsSelected = !switcherIsSelected),
        ),
        KSizedBox.kHeightSizedBox30,
      ],
    );
  }
}
