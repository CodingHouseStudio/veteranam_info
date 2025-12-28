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
      // ignore: avoid_print
      print('=== STRIPE CHECKOUT HELPER ===');
      // ignore: avoid_print
      print('Company ID: $companyId');
      // ignore: avoid_print
      print('Success URL: ${_getSuccessUrl()}');
      // ignore: avoid_print
      print('Cancel URL: ${_getCancelUrl()}');

      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      // ignore: avoid_print
      print('Checkout URL received: $checkoutUrl');

      if (checkoutUrl == null) {
        // ignore: avoid_print
        print('ERROR: Checkout URL is null');
        throw StripeCheckoutException('Failed to create checkout session');
      }

      final uri = Uri.parse(checkoutUrl);
      // ignore: avoid_print
      print('Launching URL: $uri');

      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      // ignore: avoid_print
      print('URL launched successfully: $launched');

      if (!launched) {
        // ignore: avoid_print
        print('ERROR: Failed to launch URL');
        throw StripeCheckoutException(
          'Failed to open Stripe Checkout. Please check your browser settings.',
        );
      }

      // ignore: avoid_print
      print('=== CHECKOUT HELPER SUCCESS ===');
      return true;
    } catch (e) {
      // ignore: avoid_print
      print('=== CHECKOUT HELPER ERROR ===');
      // ignore: avoid_print
      print('Error: $e');
      // ignore: avoid_print
      print('Error type: ${e.runtimeType}');
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
