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
      debugPrint('=== STRIPE CHECKOUT HELPER ===');
      debugPrint('Company ID: $companyId');
      debugPrint('Success URL: ${_getSuccessUrl()}');
      debugPrint('Cancel URL: ${_getCancelUrl()}');

      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      debugPrint('Checkout URL received: $checkoutUrl');

      if (checkoutUrl == null) {
        debugPrint('ERROR: Checkout URL is null');
        throw StripeCheckoutException('Failed to create checkout session');
      }

      final uri = Uri.parse(checkoutUrl);
      debugPrint('Launching URL: $uri');

      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      debugPrint('URL launched successfully: $launched');

      if (!launched) {
        debugPrint('ERROR: Failed to launch URL');
        throw StripeCheckoutException(
          'Failed to open Stripe Checkout. Please check your browser settings.',
        );
      }

      debugPrint('=== CHECKOUT HELPER SUCCESS ===');
      return true;
    } catch (e) {
      debugPrint('=== CHECKOUT HELPER ERROR ===');
      debugPrint('Error: $e');
      debugPrint('Error type: ${e.runtimeType}');
      if (e is StripeCheckoutException) {
        rethrow;
      }
      throw StripeCheckoutException(e.toString());
    }
  }

  String _getSuccessUrl() {
    if (kIsWeb) {
      // Use current origin + success path
      return '${Uri.base.origin}/subscription/success';
    }
    // For mobile (if ever needed)
    return 'veteranam://subscription/success';
  }

  /// Get cancel redirect URL based on environment
  String _getCancelUrl() {
    if (kIsWeb) {
      // Use current origin + cancel path
      return '${Uri.base.origin}/subscription/canceled';
    }
    // For mobile
    return 'veteranam://subscription/canceled';
  }
}

class StripeCheckoutException implements Exception {
  StripeCheckoutException(this.message);

  final String message;

  @override
  String toString() => 'StripeCheckoutException: $message';
}
