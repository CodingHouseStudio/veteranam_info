import 'package:flutter/material.dart';
import 'package:kozak/shared/shared.dart';

class ProfileSavesBody extends StatelessWidget {
  const ProfileSavesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        ...TitleWidget.titleWidgetList(
          title: context.l10n.saved,
          titleKey: KWidgetkeys.screen.profileSaves.title,
          subtitle: context.l10n.savesSubtitle,
          subtitleKey: KWidgetkeys.screen.profileSaves.subtitle,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        Container(
          margin: EdgeInsetsDirectional.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize220 : KPadding.kPaddingSize16,
          ),
          child: DiscountsCardWidget(
            key: KWidgetkeys.screen.profileSaves.discountCard,
            discount: KMockText.discount,
            city: KMockText.cityDiscount,
            service: KMockText.serviceDiscount,
            description: KMockText.descriptionDiscount,
            date: KMockText.dateDiscount,
            instruction: KMockText.instructionDiscount,
            preInstructionDiscount: KMockText.preInstructionDiscount,
            isDesk: isDesk,
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        Container(
          margin: EdgeInsetsDirectional.symmetric(
            horizontal:
                isDesk ? KPadding.kPaddingSize220 : KPadding.kPaddingSize16,
          ),
          child: WorkCardWidget(
            key: KWidgetkeys.screen.profileSaves.workCard,
            workModel: KMockText.workModel,
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
