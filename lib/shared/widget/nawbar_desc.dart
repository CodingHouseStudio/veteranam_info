import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class NawbarDesc extends StatelessWidget implements PreferredSizeWidget {
  const NawbarDesc({required this.search, super.key});
  final void Function(String text) search;

  @override
  Size get preferredSize => const Size.fromHeight(KSize.kPreferredSize);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: KBorderRadius.kBorderRadiusM,
        color: AppColors.widgetBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(KPadding.kPaddingSizeS),
        child: Row(
          children: [
            KSizedBox.kWidthSizedBoxM,
            Text(
              KAppText.appName,
              key: KWidgetkeys.nawbarKeys.title,
              style: AppTextStyle.title,
            ),
            KSizedBox.kWidthSizedBoxML,
            Expanded(
              child: TextFieldWidget(
                hintStyle: AppTextStyle.lableMedium,
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
                style: AppTextStyle.lableMedium,
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
