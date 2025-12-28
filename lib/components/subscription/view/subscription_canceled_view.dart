import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class SubscriptionCanceledScreen extends StatelessWidget {
  const SubscriptionCanceledScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScaffoldWidget(
      mainChildWidgetsFunction: ({required isDesk, required isTablet}) => [
        if (isDesk)
          KSizedBox.kHeightSizedBox80
        else
          KSizedBox.kHeightSizedBox40,
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(KPadding.kPaddingSize32),
            decoration: KWidgetTheme.boxDecorationHome,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.cancel_outlined,
                  size: 80,
                  color: AppColors.materialThemeRefErrorError40,
                ),
                KSizedBox.kHeightSizedBox24,
                Text(
                  'Subscription Canceled',
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineLarge
                      : AppTextStyle.materialThemeHeadlineSmall,
                  textAlign: TextAlign.center,
                ),
                KSizedBox.kHeightSizedBox16,
                const Text(
                  'You have canceled the subscription setup. You can '
                  'complete this step later from your company profile.',
                  style: AppTextStyle.materialThemeBodyLarge,
                  textAlign: TextAlign.center,
                ),
                KSizedBox.kHeightSizedBox32,
                DoubleButtonWidget(
                  text: 'Go to Company Profile',
                  isDesk: isDesk,
                  widgetKey: const Key('subscription_canceled_button'),
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
