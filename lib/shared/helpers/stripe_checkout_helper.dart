import 'dart:developer' as developer;

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
      developer.log('=== STRIPE CHECKOUT HELPER ===', name: 'StripeCheckout');
      developer.log('Company ID: $companyId', name: 'StripeCheckout');
      developer.log('Success URL: ${_getSuccessUrl()}', name: 'StripeCheckout');
      developer.log('Cancel URL: ${_getCancelUrl()}', name: 'StripeCheckout');

      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      developer.log('Checkout URL received: $checkoutUrl', name: 'StripeCheckout');

      if (checkoutUrl == null) {
        developer.log('ERROR: Checkout URL is null', name: 'StripeCheckout');
        throw StripeCheckoutException('Failed to create checkout session');
      }

      final uri = Uri.parse(checkoutUrl);
      developer.log('Launching URL: $uri', name: 'StripeCheckout');

      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      developer.log('URL launched successfully: $launched', name: 'StripeCheckout');

      if (!launched) {
        developer.log('ERROR: Failed to launch URL', name: 'StripeCheckout');
        throw StripeCheckoutException(
          'Failed to open Stripe Checkout. Please check your browser settings.',
        );
      }

      developer.log('=== CHECKOUT HELPER SUCCESS ===', name: 'StripeCheckout');
      return true;
    } catch (e) {
      developer.log('=== CHECKOUT HELPER ERROR ===', name: 'StripeCheckout');
      developer.log('Error: $e', name: 'StripeCheckout');
      developer.log('Error type: ${e.runtimeType}', name: 'StripeCheckout');
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
