import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veteranam/shared/models/enums/subscription_enums.dart';
import 'package:veteranam/shared/shared_flutter.dart';

/// Widget that displays subscription information
/// Shows status, plan, trial/billing period dates
class SubscriptionInfoWidget extends StatelessWidget {
  const SubscriptionInfoWidget({
    required this.company,
    required this.isDesk,
    super.key,
  });

  final CompanyModel company;
  final bool isDesk;

  @override
  Widget build(BuildContext context) {
    // Don't show if no subscription
    if (company.subscriptionStatus == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.materialThemeKeyColorsNeutral,
        borderRadius: BorderRadius.circular(KSize.kPixel12),
        border: Border.all(
          color: AppColors.materialThemeRefNeutralNeutral90,
        ),
      ),
      padding: EdgeInsets.all(
        isDesk ? KPadding.kPaddingSize24 : KPadding.kPaddingSize16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: KPadding.kPaddingSize16,
        children: [
          // Header with status badge
          Row(
            children: [
              Expanded(
                child: Text(
                  'Subscription',
                  style: isDesk
                      ? AppTextStyle.materialThemeHeadlineSmall
                      : AppTextStyle.materialThemeTitleLarge,
                ),
              ),
              _buildStatusBadge(),
            ],
          ),

          // Divider
          const Divider(
            color: AppColors.materialThemeRefNeutralNeutral90,
          ),

          // Plan info
          if (company.subscriptionPlan != null)
            _buildInfoRow(
              'Plan',
              company.subscriptionPlan!.displayName,
              isDesk,
            ),

          // Status-specific information
          if (company.isInTrial) ...[
            _buildInfoRow(
              'Trial Status',
              'Active (${company.trialDaysRemaining} days left)',
              isDesk,
            ),
            if (company.trialExpiresAt != null)
              _buildInfoRow(
                'Trial Expires',
                _formatDate(company.trialExpiresAt!),
                isDesk,
              ),
          ] else if (company.subscriptionStatus == SubscriptionStatus.active) ...[
            if (company.subscriptionExpiresAt != null)
              _buildInfoRow(
                'Renews On',
                _formatDate(company.subscriptionExpiresAt!),
                isDesk,
              ),
          ] else if (company.subscriptionStatus == SubscriptionStatus.canceled ||
              company.subscriptionStatus == SubscriptionStatus.expired) ...[
            if (company.canceledAt != null)
              _buildInfoRow(
                'Canceled On',
                _formatDate(company.canceledAt!),
                isDesk,
              ),
            if (company.subscriptionExpiresAt != null)
              _buildInfoRow(
                'Access Until',
                _formatDate(company.subscriptionExpiresAt!),
                isDesk,
              ),
          ] else if (company.needsPaymentAction) ...[
            _buildWarningRow(
              'Action Required',
              'Please update your payment method',
              isDesk,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    final status = company.subscriptionStatus!;
    Color backgroundColor;
    Color textColor;
    String label;

    switch (status) {
      case SubscriptionStatus.active:
        backgroundColor = AppColors.materialThemeRefPrimaryPrimary60;
        textColor = AppColors.materialThemeWhite;
        label = 'Active';
      case SubscriptionStatus.trialing:
        backgroundColor = AppColors.materialThemeRefPrimaryPrimary80;
        textColor = AppColors.materialThemeWhite;
        label = 'Trial';
      case SubscriptionStatus.canceled:
      case SubscriptionStatus.expired:
        backgroundColor = AppColors.materialThemeRefNeutralNeutral60;
        textColor = AppColors.materialThemeWhite;
        label = status == SubscriptionStatus.canceled
            ? 'Canceled'
            : 'Expired';
      case SubscriptionStatus.pastDue:
      case SubscriptionStatus.unpaid:
        backgroundColor = AppColors.materialThemeRefErrorError40;
        textColor = AppColors.materialThemeWhite;
        label = 'Payment Due';
      case SubscriptionStatus.incomplete:
      case SubscriptionStatus.incompleteExpired:
        backgroundColor = AppColors.materialThemeRefNeutralNeutral60;
        textColor = AppColors.materialThemeWhite;
        label = 'Incomplete';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KPadding.kPaddingSize12,
        vertical: KPadding.kPaddingSize4,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(KSize.kPixel16),
      ),
      child: Text(
        label,
        style: AppTextStyle.materialThemeLabelMedium.copyWith(
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDesk) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: isDesk
                ? AppTextStyle.materialThemeBodyMedium
                : AppTextStyle.materialThemeBodySmall,
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: isDesk
                ? AppTextStyle.materialThemeBodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  )
                : AppTextStyle.materialThemeBodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Widget _buildWarningRow(String label, String value, bool isDesk) {
    return Container(
      padding: const EdgeInsets.all(KPadding.kPaddingSize12),
      decoration: BoxDecoration(
        color: AppColors.materialThemeRefErrorError90,
        borderRadius: BorderRadius.circular(KSize.kPixel8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.warning,
            color: AppColors.materialThemeRefErrorError40,
            size: KSize.kPixel20,
          ),
          KSizedBox.kWidthSizedBox8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: KPadding.kPaddingSize4,
              children: [
                Text(
                  label,
                  style: isDesk
                      ? AppTextStyle.materialThemeBodySmall.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.materialThemeRefErrorError40,
                        )
                      : AppTextStyle.materialThemeLabelMedium.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.materialThemeRefErrorError40,
                        ),
                ),
                Text(
                  value,
                  style: isDesk
                      ? AppTextStyle.materialThemeBodySmall
                      : AppTextStyle.materialThemeLabelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }
}
