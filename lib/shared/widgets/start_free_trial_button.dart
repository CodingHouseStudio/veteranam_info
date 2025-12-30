import 'package:flutter/material.dart';
import 'package:veteranam/shared/helpers/stripe_checkout_helper.dart';
import 'package:veteranam/shared/shared_flutter.dart';

class StartFreeTrialButton extends StatefulWidget {
  const StartFreeTrialButton({
    required this.companyId,
    required this.isDesk,
    super.key,
  });

  final String companyId;
  final bool isDesk;

  @override
  State<StartFreeTrialButton> createState() => _StartFreeTrialButtonState();
}

class _StartFreeTrialButtonState extends State<StartFreeTrialButton> {
  bool _isLoading = false;
  final _stripeCheckoutHelper = StripeCheckoutHelper();

  Future<void> _startFreeTrial() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _stripeCheckoutHelper.openCheckout(
        companyId: widget.companyId,
      );
    } catch (e) {
      // Show error to user
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to start trial: $e'),
            backgroundColor: AppColors.materialThemeRefErrorError40,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SkeletonizerWidget(
      isLoading: _isLoading,
      child: BoxWidget(
        text: context.l10n.startFreeTrial,
        iconText: context.l10n.unlockDiscountFeatures,
        onTap: _isLoading ? null : _startFreeTrial,
        isDesk: widget.isDesk,
        icon: const Icon(
          Icons.rocket_launch,
          color: AppColors.materialThemeRefPrimaryPrimary40,
        ),
      ),
    );
  }
}
