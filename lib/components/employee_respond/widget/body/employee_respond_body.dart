import 'package:flutter/material.dart';
import 'package:kozak/components/employee_respond/widget/employee_respond_container_widget.dart';
import 'package:kozak/shared/shared.dart';

class EmployeeRespondBodyWidget extends StatelessWidget {
  const EmployeeRespondBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox68
        else
          KSizedBox.kHeightSizedBox78,
        Text(
          key: KWidgetkeys.screen.employeeRespond.title,
          context.l10n.respond,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Row(
          children: [
            KIcon.chevronLeft,
            Text(
              key: KWidgetkeys.screen.employeeRespond.subtitle,
              KMockText.workTitle,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        EmployeeRespondContainerWidget(isDesk: isDesk),
      ],
    );
  }
}
