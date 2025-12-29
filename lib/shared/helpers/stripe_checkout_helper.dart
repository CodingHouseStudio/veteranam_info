import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/services/subscription_service.dart';

/// Helper for opening Stripe Checkout in a popup/new tab
class StripeCheckoutHelper {
  StripeCheckoutHelper({SubscriptionService? subscriptionService})
      : _subscriptionService = subscriptionService ?? SubscriptionService();

  final SubscriptionService _subscriptionService;

  Future<bool> openCheckout({
    required String companyId,
  }) async {
    try {
      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      if (checkoutUrl == null) {
        throw StripeCheckoutException('Failed to create checkout session');
      }

      final uri = Uri.parse(checkoutUrl);

      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      if (!launched) {
        throw StripeCheckoutException(
          'Failed to open Stripe Checkout. Please check your browser settings.',
        );
      }

      return true;
    } catch (e) {
      if (e is StripeCheckoutException) {
        rethrow;
      }
      throw StripeCheckoutException(e.toString());
    }
  }

  String _getSuccessUrl() {
    if (kIsWeb) {
      return '${Uri.base.origin}/subscription/success';
    }
    return 'veteranam://subscription/success';
  }

  String _getCancelUrl() {
    if (kIsWeb) {
      return '${Uri.base.origin}/subscription/canceled';
    }
    return 'veteranam://subscription/canceled';
  }
}

class StripeCheckoutException implements Exception {
  StripeCheckoutException(this.message);

  final String message;

  @override
  String toString() => 'StripeCheckoutException: $message';
}
