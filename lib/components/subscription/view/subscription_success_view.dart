import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SubscriptionSuccessScreen extends StatelessWidget {
  const SubscriptionSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        if (isDesk) KSizedBox.kHeightSizedBox80 else KSizedBox.kHeightSizedBox40,
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(KPadding.kPaddingSize32),
            decoration: KWidgetTheme.boxDecorationHome,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle,
                  size: 80,
                  color: AppColors.materialThemeKeyColorsPrimary,
                ),
                KSizedBox.kHeightSizedBox24,
                Text(
                  'Subscription Activated!',
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                  textAlign: TextAlign.center,
                ),
                KSizedBox.kHeightSizedBox16,
                const Text(
                  'Your 30-day trial has started. You can now create '
                  'discounts for your company.',
                  style: AppTextStyle.materialThemeBodyLarge,
                  textAlign: TextAlign.center,
                ),
                KSizedBox.kHeightSizedBox32,
                DoubleButtonWidget(
                  text: 'Go to Company Profile',
                  isDesk: isDesk,
                  widgetKey: const Key('subscription_success_button'),
                  onPressed: () => context.goNamed(KRoute.company.name),
                  color: AppColors.materialThemeKeyColorsPrimary,
                  deskPadding: const EdgeInsets.symmetric(
                    vertical: KPadding.kPaddingSize16,
                    horizontal: KPadding.kPaddingSize52,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
