import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

part '../text_field_widget_list.dart';

class EmployerBodyWidget extends StatelessWidget {
  const EmployerBodyWidget({super.key});

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
          key: KWidgetkeys.screen.employer.title,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.employerSubtitle,
          key: KWidgetkeys.screen.employer.subtitle,
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        Text(
          context.l10n.mainInformation,
          key: KWidgetkeys.screen.employer.mainInformation,
          style: isDesk ? AppTextStyle.text64 : AppTextStyle.text32,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox48
        else
          KSizedBox.kHeightSizedBox16,
        ..._textFieldWidgetList(context: context, isDesk: isDesk),
        Align(
          alignment: Alignment.centerLeft,
          child: ButtonWidget(
            key: KWidgetkeys.screen.employer.button,
            text: context.l10n.next,
            onPressed: null,
            isDesk: isDesk,
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
      ],
    );
  }
}
