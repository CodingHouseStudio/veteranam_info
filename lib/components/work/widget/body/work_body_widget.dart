import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class WorkBodyWidget extends StatelessWidget {
  const WorkBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        Text(
          context.l10n.work,
          key: KWidgetkeys.screen.work.title,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox30 else KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.workSubtitle,
          key: KWidgetkeys.screen.work.subtitle,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox120
        else
          KSizedBox.kHeightSizedBox64,
        if (isDesk)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxWidget(
                key: KWidgetkeys.screen.work.boxEmployee,
                text: context.l10n.lookingForJob,
                onTap: () =>
                    context.goNamedWithScroll(KRoute.workEmployee.name),
                isDesk: true,
                textRightPadding: KPadding.kPaddingSize100,
              ),
              KSizedBox.kWidthSizedBox56,
              BoxWidget(
                key: KWidgetkeys.screen.work.boxEmployer,
                text: context.l10n.givingJob,
                onTap: () => context.goNamedWithScroll(KRoute.employer.name),
                isDesk: true,
                textRightPadding: KPadding.kPaddingSize100,
              ),
            ],
          )
        else ...[
          BoxWidget(
            key: KWidgetkeys.screen.work.boxEmployee,
            text: context.l10n.lookingForJob,
            onTap: () => context.goNamedWithScroll(KRoute.workEmployee.name),
            isDesk: false,
            textRightPadding: KPadding.kPaddingSize100,
          ),
          KSizedBox.kHeightSizedBox40,
          BoxWidget(
            key: KWidgetkeys.screen.work.boxEmployer,
            text: context.l10n.givingJob,
            onTap: () => context.goNamedWithScroll(KRoute.employer.name),
            isDesk: false,
            textRightPadding: KPadding.kPaddingSize100,
          ),
        ],
        if (isDesk)
          KSizedBox.kHeightSizedBox120
        else
          KSizedBox.kHeightSizedBox64,
      ],
    );
  }
}
