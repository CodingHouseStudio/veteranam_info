import 'package:flutter/material.dart';
import 'package:kozak/components/help_find_job/widget/body/help_find_job_body_contact_widget.dart';
import 'package:kozak/shared/shared.dart';

class HelpFindJobDetails extends StatelessWidget {
  const HelpFindJobDetails({
    required this.onNextPressed,
    required this.onBackPressed,
    super.key,
  });

  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return ScaffoldDecorationWidget(
      titleChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        ...TitleWidget.titleWidgetList(
          title: context.l10n.writeWishesTitle,
          titleKey: KWidgetkeys.screen.helpFindJob.titleDetails,
          subtitle: context.l10n.writeWishesSubtitle,
          subtitleKey: KWidgetkeys.screen.helpFindJob.titleDetails,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize220 : KPadding.kPaddingSize8,
          ),
          child: CustomPaint(
            painter: ViewpagerIndicatorWidget(
              pageCount: 3,
              selectedPage: 1,
              pageTitles: [
                context.l10n.contacts,
                context.l10n.details,
                context.l10n.skills,
              ],
              isDesk: isDesk,
            ),
            child: const SizedBox(
              height: 50,
              width: double.infinity,
            ),
          ),
        ),
      ],
      mainDecoration: KWidgetTheme.boxDecorationWidget,
      mainPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: isDesk ? maxWidth * KDimensions.respondPaddingMultiply : 0,
        vertical: isDesk ? KPadding.kPaddingSize40 : KPadding.kPaddingSize24,
      ),
      mainDecorationPadding: ({required isDesk}) => EdgeInsets.all(
        isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      mainChildWidgetsFunction: ({required isDesk}) => [
        ..._areaOfActivityContainerWidgetList(
          context: context,
          isDesk: isDesk,
          onNextPressed: onNextPressed,
          onBackPressed: onBackPressed,
        ),
      ],
    );
  }
}

List<Widget> _areaOfActivityContainerWidgetList({
  required BuildContext context,
  required bool isDesk,
  required VoidCallback onBackPressed,
  required VoidCallback onNextPressed,
}) {
  return [
    if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Text(
        key: KWidgetkeys.screen.helpFindJob.textCity,
        context.l10n.city,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    DropListFieldWidget(
      key: KWidgetkeys.screen.helpFindJob.fieldCity,
      onChanged: null,
      hintText: context.l10n.selectCity,
      dropDownList: KMockText.dropDownList,
      isDesk: isDesk,
    ),
    if (isDesk == false) KSizedBox.kHeightSizedBox8,
    if (isDesk == false)
      Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
        child: Row(
          children: [
            SwitchWidgetWithoutBloc(
              key: KWidgetkeys.screen.helpFindJob.switchWidget,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: KPadding.kPaddingSize10,
              ),
              child: Text(
                key: KWidgetkeys.screen.helpFindJob.textSwitchWidget,
                context.l10n.remotely,
                style: AppTextStyle.text16,
              ),
            ),
          ],
        ),
      ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Text(
        key: KWidgetkeys.screen.helpFindJob.phoneNumberText,
        context.l10n.positionMain,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    TextFieldWidget(
      widgetKey: KWidgetkeys.screen.helpFindJob.fieldPosition,
      hintText: context.l10n.desiredPosition,
      onChanged: null,
      isDesk: isDesk,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      child: Text(
        key: KWidgetkeys.screen.helpFindJob.textCategory,
        context.l10n.category,
        style: isDesk ? AppTextStyle.text32 : AppTextStyle.text16,
      ),
    ),
    KSizedBox.kHeightSizedBox8,
    DropListFieldWidget(
      key: KWidgetkeys.screen.helpFindJob.fieldCategory,
      onChanged: null,
      hintText: context.l10n.selectCategory,
      dropDownList: KMockText.dropDownList,
      isDesk: isDesk,
    ),
    if (isDesk) KSizedBox.kHeightSizedBox32 else KSizedBox.kHeightSizedBox16,
    if (isDesk)
      Row(
        children: [
          Expanded(
            child: backButton(
              context: context,
              isDesk: true,
              onBackPressed: onBackPressed,
            ),
          ),
          if (isDesk)
            KSizedBox.kWidthSizedBox73
          else
            KSizedBox.kHeightSizedBox16,
          Expanded(
            child: nextButton(
              context: context,
              isDesk: true,
              onNextPressed: onNextPressed,
            ),
          ),
        ],
      )
    else ...[
      backButton(context: context, isDesk: false, onBackPressed: onBackPressed),
      KSizedBox.kHeightSizedBox16,
      nextButton(context: context, isDesk: false, onNextPressed: onNextPressed),
    ],
    if (isDesk) KSizedBox.kHeightSizedBox56 else KSizedBox.kHeightSizedBox24,
  ];
}

Widget backButton({
  required BuildContext context,
  required bool isDesk,
  required VoidCallback onBackPressed,
}) =>
    ButtonWidget(
      key: KWidgetkeys.screen.helpFindJob.backButton,
      text: context.l10n.back,
      onPressed: onBackPressed,
      isDesk: isDesk,
      backgroundColor: AppColors.materialThemeRefTertiaryTertiary100,
    );
