import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class NawbarDesc extends StatelessWidget {
  const NawbarDesc({required this.search, super.key});
  final void Function(String text) search;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: KWidetTheme.boxDecorationCard,
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
        child: Row(
          children: [
            KSizedBox.kWidthSizedBoxM,
            Text(
              KAppText.appName,
              key: KWidgetkeys.nawbarKeys.title,
              style: KAppTextStyle.title,
            ),
            KSizedBox.kWidthSizedBoxML,
            Expanded(
              child: TextFieldWidget(
                hintStyle: KAppTextStyle.lableMedium,
                widgetKey: KWidgetkeys.nawbarKeys.field,
                prefixIcon: KIcon.search,
                onChanged: search,
                hintText: KAppText.searchTextFieldHint,
              ),
            ),
            IconWidget(
              key: KWidgetkeys.nawbarKeys.iconMic,
              icon: KIcon.mic,
            ),
            KSizedBox.kWidthSizedBoxML,
            TextButton(
              key: KWidgetkeys.nawbarKeys.button,
              style: KButtonStyles.whiteButtonStyle,
              onPressed: null,
              child: const Text(
                KAppText.enterButtonText,
                style: KAppTextStyle.lableMedium,
              ),
            ),
            IconWidget(
              key: KWidgetkeys.nawbarKeys.iconPerson,
              icon: KIcon.person,
            ),
          ],
        ),
      ),
    );
  }
}
