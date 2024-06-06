import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

part '../employee_respond_container_widget.dart';

class EmployeeRespondBodyWidget extends StatelessWidget {
  const EmployeeRespondBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldDecorationWidget(
      titleChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox68
        else
          KSizedBox.kHeightSizedBox32,
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
      ],
      mainDecoration: KWidgetTheme.boxDecorationWidget,
      mainPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: isDesk ? maxWidth * KDimensions.paddingMultiply : 0,
        vertical: isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
      ),
      mainDecorationPadding: ({required isDesk}) => EdgeInsets.all(
        isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      mainChildWidgetsFunction: ({required isDesk}) =>
          _employeeRespondContainerWidgetList(
        context: context,
        isDesk: isDesk,
      ),
    );
  }
}
