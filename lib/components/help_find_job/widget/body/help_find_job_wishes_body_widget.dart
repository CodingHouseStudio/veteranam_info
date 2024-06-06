import 'package:flutter/material.dart';
import 'package:kozak/components/help_find_job/widget/body/help_find_job_details_body_widget.dart';
import 'package:kozak/shared/shared.dart';

class HelpFindJobWishes extends StatefulWidget {
  const HelpFindJobWishes({
    required this.onLeaveRequestPressed,
    required this.onBackPressed,
    super.key,
  });

  final VoidCallback onLeaveRequestPressed;
  final VoidCallback onBackPressed;

  @override
  HelpFindJobWishesState createState() => HelpFindJobWishesState();
}

class HelpFindJobWishesState extends State<HelpFindJobWishes> {
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

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
          titleKey: KWidgetkeys.screen.helpFindJob.titleWishes,
          subtitle: context.l10n.desiredWishes,
          subtitleKey: KWidgetkeys.screen.helpFindJob.subtitleWishes,
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
              selectedPage: 2,
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
      mainPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: isDesk ? maxWidth * KDimensions.respondPaddingMultiply : 0,
        vertical: isDesk ? KPadding.kPaddingSize40 : KPadding.kPaddingSize24,
      ),
      mainChildWidgetsFunction: ({required isDesk}) => [
        ..._writeYourWishesWidgetList(
          context: context,
          isDesk: isDesk,
          onLeaveRequestPressed: widget.onLeaveRequestPressed,
          onBackPressed: widget.onBackPressed,
          messageController: messageController,
        ),
      ],
    );
  }

  List<Widget> _writeYourWishesWidgetList({
    required BuildContext context,
    required bool isDesk,
    required VoidCallback onBackPressed,
    required VoidCallback onLeaveRequestPressed,
    required TextEditingController messageController,
    String? messageHint,
  }) {
    return [
      if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
      MessageFieldWidget(
        key: KWidgetkeys.widget.feedback.fieldMessage,
        controller: messageController,
        hintText: messageHint ?? context.l10n.writeWishes,
        isDesk: isDesk,
        changeMessage: (String text) {},
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
              child: ButtonWidget(
                key: KWidgetkeys.widget.feedback.buttonSave,
                text: context.l10n.sendARequest,
                onPressed: onLeaveRequestPressed,
                isDesk: isDesk,
              ),
            ),
          ],
        )
      else ...[
        ButtonWidget(
          backgroundColor: AppColors.materialThemeKeyColorsNeutralVariant,
          key: KWidgetkeys.widget.feedback.buttonSave,
          text: context.l10n.send,
          onPressed: onLeaveRequestPressed,
          isDesk: isDesk,
        ),
        KSizedBox.kHeightSizedBox16,
        backButton(
          context: context,
          isDesk: false,
          onBackPressed: onBackPressed,
        ),
        KSizedBox.kHeightSizedBox16,
      ],
      if (isDesk) KSizedBox.kHeightSizedBox56 else KSizedBox.kHeightSizedBox24,
    ];
  }
}
