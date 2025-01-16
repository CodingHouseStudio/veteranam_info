import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class MyDiscountPageWithEmptyProfileWidget extends StatelessWidget {
  const MyDiscountPageWithEmptyProfileWidget({
    required this.isDesk,
    super.key,
  });
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: KPadding.kPaddingSize80,
        horizontal: isDesk ? KPadding.kPaddingSize160 : KPadding.kPaddingSize32,
      ),
      child: Column(
        spacing: KPadding.kPaddingSize40,
        children: [
          Text(
            key: MyDiscountsKeys.emptyProfileText,
            context.l10n.profileNotFilledOut,
            textAlign: TextAlign.center,
            style: isDesk
                ? AppTextStyle.materialThemeTitleLarge
                : AppTextStyle.materialThemeTitleSmall,
          ),
          DoubleButtonWidget(
            widgetKey: MyDiscountsKeys.buttonProfile,
            text: context.l10n.toProfile,
            isDesk: isDesk,
            darkMode: true,
            // color: AppColors.materialThemeKeyColorsSecondary,
            // textColor: AppColors.materialThemeWhite,
            onPressed: () => context.goNamed(KRoute.company.name),
            icon: KIcon.personWhite,
            deskPadding: const EdgeInsets.symmetric(
              vertical: KPadding.kPaddingSize16,
              horizontal: KPadding.kPaddingSize64,
            ),
            angle: 0,
            deskIconPadding: KPadding.kPaddingSize16,
            align: Alignment.center,
            mobIconPadding: KPadding.kPaddingSize16,
            mobHorizontalTextPadding: KPadding.kPaddingSize60,
            mobVerticalTextPadding: KPadding.kPaddingSize16,
          ),
        ],
      ),
    );
  }
}
