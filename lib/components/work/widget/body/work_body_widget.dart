import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared.dart';

class WorkBodyWidget extends StatelessWidget {
  const WorkBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        ...TitleWidget.titleWidgetList(
          title: context.l10n.work,
          titleKey: KWidgetkeys.screen.work.title,
          subtitle: context.l10n.workSubtitle,
          subtitleKey: KWidgetkeys.screen.work.subtitle,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox120
        else
          KSizedBox.kHeightSizedBox64,
        if (isDesk)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: boxWidgets(context: context, isDesk: isDesk),
          )
        else
          ...boxWidgets(context: context, isDesk: isDesk),
        if (isDesk)
          KSizedBox.kHeightSizedBox120
        else
          KSizedBox.kHeightSizedBox64,
      ],
    );
  }

  List<Widget> boxWidgets({
    required BuildContext context,
    required bool isDesk,
  }) =>
      [
        BoxWidget(
          key: KWidgetkeys.screen.work.boxEmployee,
          text: context.l10n.lookingForJob,
          onTap: () => context.goNamed(KRoute.workEmployee.name),
          isDesk: isDesk,
          textRightPadding: KPadding.kPaddingSize100,
        ),
        if (isDesk) KSizedBox.kWidthSizedBox56 else KSizedBox.kHeightSizedBox40,
        BoxWidget(
          key: KWidgetkeys.screen.work.boxEmployer,
          text: context.l10n.givingJob,
          onTap: () => context.goNamed(KRoute.employer.name),
          isDesk: isDesk,
          textRightPadding: KPadding.kPaddingSize100,
        ),
      ];
}
