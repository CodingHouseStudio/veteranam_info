import 'package:flutter/cupertino.dart';
import 'package:kozak/shared/shared.dart';

class ThanksBodyWidget extends StatelessWidget {
  const ThanksBodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      childWidgetsFunction: ({required isDesk}) => [
        KSizedBox.kHeightSizedBox30,
        Padding(
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize4,
          ),
          child: Text(
            context.l10n.thankYou,
            style: isDesk ? AppTextStyle.text96 : AppTextStyle.text32,
          ),
        ),
        KSizedBox.kHeightSizedBox8,
        Padding(
          padding: const EdgeInsets.only(
            left: KPadding.kPaddingSize4,
          ),
          child: Text(
            context.l10n.thankYouDescription,
            style: isDesk ? AppTextStyle.text24 : AppTextStyle.text16,
          ),
        ),
        if (isDesk)
          KSizedBox.kHeightSizedBox90
        else
          KSizedBox.kHeightSizedBox56,
        if (isDesk)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BoxWidget(
                text: context.l10n.myProfile,
                isDesk: true,
                onTap: () => context.goNamedWithScroll(KRoute.profile.name),
                textRightPadding: KPadding.kPaddingSize90,
              ),
              KSizedBox.kWidthSizedBox56,
              BoxWidget(
                text: context.l10n.mainScreen,
                isDesk: true,
                onTap: () => context.goNamedWithScroll(KRoute.home.name),
                textRightPadding: KPadding.kPaddingSize128,
              ),
            ],
          )
        else ...[
          _buildBoxWidgets(context, isDesk),
        ],
        if (isDesk)
          KSizedBox.kHeightSizedBox90
        else
          KSizedBox.kHeightSizedBox56,
      ],
    );
  }

  Widget _buildBoxWidgets(BuildContext context, bool isDesk) {
    return Column(
      children: [
        BoxWidget(
          text: context.l10n.myProfile,
          isDesk: false,
          onTap: () => context.goNamedWithScroll(KRoute.profile.name),
          textRightPadding: KPadding.kPaddingSize100,
        ),
        KSizedBox.kHeightSizedBox40,
        BoxWidget(
          text: context.l10n.mainScreen,
          isDesk: false,
          onTap: () => context.goNamedWithScroll(KRoute.home.name),
          textRightPadding: KPadding.kPaddingSize100,
        ),
      ],
    );
  }
}
