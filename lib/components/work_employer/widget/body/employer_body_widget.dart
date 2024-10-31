import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:veteranam/shared/shared_flutter.dart';

part '../text_field_widget_list.dart';

class WorkEmployerBodyWidget extends StatelessWidget {
  const WorkEmployerBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        TitleWidget(
          title: context.l10n.work,
          titleKey: KWidgetkeys.screen.employer.title,
          subtitle: context.l10n.employerSubtitle,
          subtitleKey: KWidgetkeys.screen.employer.subtitle,
          isDesk: isDesk,
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
