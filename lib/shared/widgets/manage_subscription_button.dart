import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veteranam/shared/services/subscription_service.dart';

/// Button that opens the Stripe Customer Portal
/// Allows users to manage their subscription, payment methods, and invoices
class ManageSubscriptionButton extends StatefulWidget {
  const ManageSubscriptionButton({
    required this.companyId,
    this.onError,
    super.key,
  });

  final String companyId;
  final void Function(String error)? onError;

  @override
  State<ManageSubscriptionButton> createState() =>
      _ManageSubscriptionButtonState();
}

class _ManageSubscriptionButtonState extends State<ManageSubscriptionButton> {
  final SubscriptionService _subscriptionService = SubscriptionService();
  bool _isLoading = false;

  Future<void> _openCustomerPortal() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the current URL to return to after portal visit
      final returnUrl = kIsWeb
          ? '${Uri.base.origin}/business/profile'
          : 'veteranam://business/profile';

      // Create portal session
      final portalUrl = await _subscriptionService.createPortalSession(
        companyId: widget.companyId,
        returnUrl: returnUrl,
      );

      if (portalUrl == null) {
        throw Exception('Failed to create portal session');
      }

      // Open the portal in a new tab/window
      final uri = Uri.parse(portalUrl);
      final launched = await launchUrl(
        uri,
        mode: kIsWeb
            ? LaunchMode.platformDefault
            : LaunchMode.externalApplication,
        webOnlyWindowName: '_blank',
      );

      if (!launched) {
        throw Exception('Failed to open portal. Check browser settings.');
      }
    } catch (e) {
      if (mounted) {
        final errorMessage = e.toString();
        widget.onError?.call(errorMessage);

        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $errorMessage'),
            backgroundColor: Colors.red,
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
    return ElevatedButton.icon(
      onPressed: _isLoading ? null : _openCustomerPortal,
      icon: _isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Icon(Icons.settings),
      label: const Text('Manage Subscription'),
    );
  }
}
