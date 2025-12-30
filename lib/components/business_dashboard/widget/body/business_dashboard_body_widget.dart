import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';

import 'package:veteranam/shared/shared_flutter.dart';

class BusinessDashboardBodyWidget extends StatelessWidget {
  const BusinessDashboardBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      isForm: true,
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        KSizedBox.kHeightSizedBox30,
        TitleWidget(
          title: '${context.l10n.businessDashboard}!',
          titleKey: BusinessDashboardKeys.title,
          subtitle: context.l10n.businessDashboardDescription,
          subtitleKey: BusinessDashboardKeys.subtitle,
          isDesk: isDesk,
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox90
        else
          KSizedBox.kHeightSizedBox56,
        if (isDesk)
          Row(
            spacing: KPadding.kPaddingSize56,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildBoxWidgets(context, isDesk),
          )
        else
          ..._buildBoxWidgets(context, isDesk),
        if (isDesk)
          KSizedBox.kHeightSizedBox90
        else
          KSizedBox.kHeightSizedBox56,
      ],
    );
  }

  List<Widget> _buildBoxWidgets(BuildContext context, bool isDesk) {
    return [
      BoxWidget(
        key: BusinessDashboardKeys.myProfielBox,
        text: context.l10n.myProfile,
        isDesk: isDesk,
        onTap: () => context.goNamed(KRoute.profile.name),
        textRightPadding: KPadding.kPaddingSize100,
      ),
      if (!isDesk) KSizedBox.kHeightSizedBox40,
      BoxWidget(
        key: BusinessDashboardKeys.myDiscountsBox,
        text: context.l10n.myDiscounts,
        isDesk: isDesk,
        onTap: () => context.goNamed(KRoute.myDiscounts.name),
        textRightPadding: KPadding.kPaddingSize100,
      ),
    ];
  }
}
