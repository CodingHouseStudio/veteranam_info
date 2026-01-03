import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class ThanksBodyWidget extends StatelessWidget {
  const ThanksBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        KSizedBox.kHeightSizedBox30,
        TitleWidget(
          title: '${context.l10n.thankYou}!',
          titleKey: ThanksKeys.title,
          subtitle: context.l10n.thankYouDescription,
          subtitleKey: ThanksKeys.subtitle,
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
        key: ThanksKeys.myProfielBox,
        text: context.l10n.myProfile,
        isDesk: isDesk,
        onTap: () => context.goNamed(KRoute.profile.name),
        textRightPadding: KPadding.kPaddingSize100,
      ),
      if (!isDesk) KSizedBox.kHeightSizedBox40,
      BoxWidget(
        key: ThanksKeys.homeBox,
        text: context.l10n.mainScreen,
        isDesk: isDesk,
        onTap: () => context.goNamed(KRoute.home.name),
        textRightPadding: KPadding.kPaddingSize100,
      ),
    ];
  }
}
