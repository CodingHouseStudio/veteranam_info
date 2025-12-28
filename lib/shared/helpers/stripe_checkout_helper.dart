import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/services/subscription_service.dart';
import 'package:web/web.dart' as web;

/// Helper for opening Stripe Checkout in a popup/new tab
class StripeCheckoutHelper {
  StripeCheckoutHelper({SubscriptionService? subscriptionService})
      : _subscriptionService = subscriptionService ?? SubscriptionService();

  final SubscriptionService _subscriptionService;

  Future<bool> openCheckout({
    required String companyId,
  }) async {
    try {
      if (kIsWeb) {
        web.console.log('[StripeCheckout] === STRIPE CHECKOUT HELPER ==='.toJS);
        web.console.log('[StripeCheckout] Company ID: $companyId'.toJS);
        web.console.log(
          '[StripeCheckout] Success URL: ${_getSuccessUrl()}'.toJS,
        );
        web.console.log('[StripeCheckout] Cancel URL: ${_getCancelUrl()}'.toJS);
      }

      final checkoutUrl = await _subscriptionService.createCheckoutSession(
        companyId: companyId,
        successUrl: _getSuccessUrl(),
        cancelUrl: _getCancelUrl(),
      );

      if (kIsWeb) {
        web.console.log(
          '[StripeCheckout] Checkout URL received: $checkoutUrl'.toJS,
        );
      }

      if (checkoutUrl == null) {
        if (kIsWeb) {
          web.console.log('[StripeCheckout] ERROR: Checkout URL is null'.toJS);
        }
        throw StripeCheckoutException('Failed to create checkout session');
      }

      final uri = Uri.parse(checkoutUrl);
      if (kIsWeb) {
        web.console.log('[StripeCheckout] Launching URL: $uri'.toJS);
      }

      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      if (kIsWeb) {
        web.console.log(
          '[StripeCheckout] URL launched successfully: $launched'.toJS,
        );
      }

      if (!launched) {
        if (kIsWeb) {
          web.console.log('[StripeCheckout] ERROR: Failed to launch URL'.toJS);
        }
        throw StripeCheckoutException(
          'Failed to open Stripe Checkout. Please check your browser settings.',
        );
      }

      if (kIsWeb) {
        web.console.log(
          '[StripeCheckout] === CHECKOUT HELPER SUCCESS ==='.toJS,
        );
      }
      return true;
    } catch (e) {
      if (kIsWeb) {
        web.console.log('[StripeCheckout] === CHECKOUT HELPER ERROR ==='.toJS);
        web.console.log('[StripeCheckout] Error: $e'.toJS);
        web.console.log('[StripeCheckout] Error type: ${e.runtimeType}'.toJS);
      }
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
