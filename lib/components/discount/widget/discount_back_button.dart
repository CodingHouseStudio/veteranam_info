import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class DiscountBackButton extends StatelessWidget {
  const DiscountBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButtonWidget(
          icon: KIcon.arrowBack,
          padding: KPadding.kPaddingSize8,
          background: AppColors.materialThemeKeyColorsPrimary,
          onPressed: () => context.goNamed(KRoute.discounts.name),
        ),
        KSizedBox.kWidthSizedBox8,
        Text(
          '${context.l10n.back} ${context.l10n.toDiscount.toLowerCase()}',
          style: AppTextStyle.materialThemeTitleMedium,
        ),
      ],
    );
  }
}
