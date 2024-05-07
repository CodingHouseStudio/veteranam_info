import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class EmployerBodyWidget extends StatelessWidget {
  const EmployerBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
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
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          ),
          child: Text(
            key: KWidgetkeys.screen.employer.textPosition,
            context.l10n.position,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
        ),
        if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.employer.fieldPosition,
          hintText: context.l10n.writeProposedPosition,
          onChanged: null,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox16,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          ),
          child: Text(
            key: KWidgetkeys.screen.employer.textWage,
            context.l10n.wage,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
        ),
        if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.employer.fieldWage,
          hintText: context.l10n.writeTheWage,
          onChanged: null,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox16,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          ),
          child: Text(
            key: KWidgetkeys.screen.employer.textCity,
            context.l10n.selectCityOfWork,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
        ),
        if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
        DropListFieldWidget(
          key: KWidgetkeys.screen.employer.fieldCity,
          onChanged: null,
          hintText: context.l10n.selectCity,
          dropDownList: KMockText.dropDownList,
        ),
        if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: KPadding.kPaddingSize16),
          child: Row(
            children: [
              SwitchWidget(
                key: KWidgetkeys.screen.employer.switchWidget,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: isDesk
                      ? KPadding.kPaddingSize16
                      : KPadding.kPaddingSize10,
                ),
                child: Text(
                  key: KWidgetkeys.screen.employer.textSwitchWidget,
                  context.l10n.remotely,
                  style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
                ),
              ),
            ],
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox16,
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
          ),
          child: Text(
            key: KWidgetkeys.screen.employer.textContact,
            context.l10n.contacts,
            style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
          ),
        ),
        if (isDesk) KSizedBox.kHeightSizedBox24 else KSizedBox.kHeightSizedBox8,
        TextFieldWidget(
          widgetKey: KWidgetkeys.screen.employer.fieldContact,
          hintText: context.l10n.howToContactYou,
          onChanged: null,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox32
        else
          KSizedBox.kHeightSizedBox16,
        ButtonWidget(
          key: KWidgetkeys.screen.employer.button,
          text: context.l10n.next,
          isDesk: true,
          onPressed: null,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
      ],
    );
  }
}
