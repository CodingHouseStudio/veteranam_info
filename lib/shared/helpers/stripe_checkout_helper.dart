import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/services/subscription_service.dart';

/// Helper for opening Stripe Checkout in a popup/new tab
class StripeCheckoutHelper {
  StripeCheckoutHelper({SubscriptionService? subscriptionService})
      : _subscriptionService =
            subscriptionService ?? SubscriptionService();

  final SubscriptionService _subscriptionService;

  /// Opens Stripe Checkout in a new window/tab
  /// On web, opens in popup. On mobile, opens in browser.
  /// Returns true when user returns (doesn't indicate success/failure)
  /// Actual subscription status is tracked via Firestore/webhook
  Future<bool> openCheckout({
    required String companyId,
  }) async {
    try {
      // Get checkout session from Cloud Function
      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        // Success/cancel URLs will redirect back to the app
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      if (checkoutUrl == null) {
        throw StripeCheckoutException('Failed to create checkout session');
      }

      // Launch Stripe Checkout
      final uri = Uri.parse(checkoutUrl);
      final launched = await launchUrl(
        uri,
        // On web, this opens in a new tab
        // User will be redirected back after completion
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank', // Opens in new tab on web
      );

      if (!launched) {
        throw StripeCheckoutException(
          'Failed to open Stripe Checkout. Please check your browser settings.',
        );
      }

      // Return true to indicate checkout was opened
      // Actual subscription status will be updated via webhook
      // and listened to via CompanyWatcherBloc
      return true;
    } catch (e) {
      if (e is StripeCheckoutException) {
        rethrow;
      }
      throw StripeCheckoutException(e.toString());
    }
  }

  /// Get success redirect URL based on environment
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
    // For mobile (if ever needed)
    return 'veteranam://subscription/canceled';
  }
}

/// Exception thrown when Stripe Checkout fails
class StripeCheckoutException implements Exception {
  StripeCheckoutException(this.message);

  final String message;

  @override
  String toString() => 'StripeCheckoutException: $message';
}
