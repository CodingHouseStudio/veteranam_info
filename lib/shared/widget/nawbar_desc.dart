import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class NawbarDesc extends StatelessWidget {
  const NawbarDesc({required this.search, super.key});
  final void Function(String text) search;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusM,
        color: KColorTheme.widgetBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
        child: Row(
          children: [
            KSizedBox.kWidthSizedBoxM,
            Text(
              KAppText.appName,
              key: KWidgetkeys.searchKeys.title,
              style: KAppTextStyle.title,
            ),
            KSizedBox.kWidthSizedBoxML,
            Expanded(
              child: SearchTextField(
                onChange: search,
              ),
            ),
            IconWidget(
              key: KWidgetkeys.searchKeys.iconMic,
              icon: KIcon.micIcon,
            ),
            KSizedBox.kWidthSizedBoxML,
            TextButton(
              key: KWidgetkeys.searchKeys.button,
              style: KButtonStyles.whiteButtonStyle,
              onPressed: null,
              child: const Text(
                KAppText.enterButtonText,
                style: KAppTextStyle.subTitle,
              ),
            ),
            IconWidget(
              key: KWidgetkeys.searchKeys.iconPerson,
              icon: KIcon.personIcon,
            ),
          ],
        ),
      ),
    );
  }
}
