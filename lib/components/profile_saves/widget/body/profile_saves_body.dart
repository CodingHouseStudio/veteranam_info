import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared.dart';

class ProfileSavesBody extends StatelessWidget {
  const ProfileSavesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      titleChildWidgetsFunction: ({required isDesk}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox40
        else
          KSizedBox.kHeightSizedBox24,
        TitleWidget(
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
      ],
      mainDeskPadding: ({required maxWidth}) => const EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize220,
      ),
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        DiscountCardWidget(
          key: KWidgetkeys.screen.profileSaves.discountCard,
          isDesk: isDesk,
          discountItem: KMockText.discountModel,
          // reportEvent: null,
          share: null,
          isLoading: true,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        WorkCardWidget(
          isSaved: false,
          key: KWidgetkeys.screen.profileSaves.workCard,
          workModel: const WorkModel(
            id: '',
            title: KMockText.workTitle,
            price: KMockText.workPrice,
            employerContact: KMockText.workCity,
            companyName: KMockText.workEmployer,
            description: KMockText.workDescription,
          ),
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
      ],
    );
  }
}
