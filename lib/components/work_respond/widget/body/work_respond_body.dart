import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

part '../work_respond_container_widget_list.dart';

class WorkRespondBodyWidget extends StatelessWidget {
  const WorkRespondBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      titleChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox68
        else
          KSizedBox.kHeightSizedBox32,
        Text(
          key: KWidgetkeys.screen.workRespond.title,
          context.l10n.respond,
          style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
        ),
        KSizedBox.kHeightSizedBox8,
        Row(
          children: [
            KIcon.chevronLeft,
            Text(
              key: KWidgetkeys.screen.workRespond.subtitle,
              KMockText.workTitle,
              style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
            ),
          ],
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
      ],
      mainDecoration: KWidgetTheme.boxDecorationWidget(context),
      mainDeskPadding: ({required isDesk, required maxWidth}) =>
          EdgeInsets.symmetric(
        horizontal: isDesk ? maxWidth * KDimensions.respondPaddingMultiply : 0,
        vertical: isDesk ? KPadding.kPaddingSize56 : KPadding.kPaddingSize24,
      ),
      mainDecorationPadding: ({required isDesk}) => EdgeInsets.all(
        isDesk ? KPadding.kPaddingSize32 : KPadding.kPaddingSize16,
      ),
      mainChildWidgetsFunction: ({required isDesk}) =>
          _workRespondContainerWidgetList(
        context: context,
        isDesk: isDesk,
      ),
    );
  }
}
