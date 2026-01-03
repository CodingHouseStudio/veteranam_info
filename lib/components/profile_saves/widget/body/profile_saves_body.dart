import 'package:flutter/material.dart';
import 'package:veteranam/shared/shared_flutter.dart';

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
          titleKey: ProfileSavesKeys.title,
          subtitle: context.l10n.savesSubtitle,
          subtitleKey: ProfileSavesKeys.subtitle,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
      ],
      mainDeskPadding: ({required maxWidth}) =>
          maxWidth.screenPadding(precent: KDimensions.fifteenPercent),
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        DiscountCardWidget(
          key: ProfileSavesKeys.discountCard,
          isDesk: isDesk,
          discountItem: KMockText.discountModel,
          // reportEvent: null,
          share: null,
          // isLoading: true,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox56
        else
          KSizedBox.kHeightSizedBox24,
        WorkCardWidget(
          isSaved: false,
          key: ProfileSavesKeys.workCard,
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
