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
          //key
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox30,
        KSizedBox.kHeightSizedBox8,
        Text(
          context.l10n.employerSubtitle,
          //key
          style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        if (isDesk)
          Text(
            context.l10n.mainInformation,
            //key
            style: isDesk ? AppTextStyle.text64 : AppTextStyle.text32,
          ),
        if (isDesk)
          KSizedBox.kHeightSizedBox64
        else
          KSizedBox.kHeightSizedBox16,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.position,
              style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
            ),
            KSizedBox.kHeightSizedBox24,
            TextFieldWidget(
              widgetKey: const Key('1'),
              onChanged: (value) {},
              hintText: context.l10n.writeProposedPosition,
            ),
            KSizedBox.kHeightSizedBox32,
            Text(
              context.l10n.wage,
              style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
            ),
            KSizedBox.kHeightSizedBox24,
            TextFieldWidget(
              widgetKey: const Key('2'),
              onChanged: (value) {},
              hintText: context.l10n.writeTheWage,
            ),
            KSizedBox.kHeightSizedBox32,
            Text(
              context.l10n.selectCityOfWork,
              style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
            ),
            KSizedBox.kHeightSizedBox24,
            DropListFieldWidget(
              onChanged: (text) {},
              hintText: context.l10n.selectCity,
              dropDownList: const [],
            ),
            KSizedBox.kHeightSizedBox24,
            const SwitchWidget(),
            KSizedBox.kHeightSizedBox32,
            Text(
              context.l10n.contact,
              style: isDesk ? AppTextStyle.text40 : AppTextStyle.text24,
            ),
            KSizedBox.kHeightSizedBox24,
            TextFieldWidget(
              widgetKey: const Key('4'),
              onChanged: (value) {},
              hintText: context.l10n.howToContactYou,
            ),
            KSizedBox.kHeightSizedBox32,
            ButtonWidget(
              text: context.l10n.next,
              onPressed: () {},
              isDesk: true,
            ),
            KSizedBox.kHeightSizedBox56,
          ],
        ),
      ],
    );
  }
}
