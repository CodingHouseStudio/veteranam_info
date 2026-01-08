import 'package:cloud_functions/cloud_functions.dart';
import 'package:injectable/injectable.dart';

/// Service for managing Stripe subscriptions via Cloud Functions
@injectable
class SubscriptionService {
  SubscriptionService({
    required FirebaseFunctions functions,
  }) : _functions = functions;

  final FirebaseFunctions _functions;

  /// Creates a Stripe Checkout session for subscription trial
  /// Returns the checkout URL to redirect the user to
  Future<String?> createCheckoutSession({
    required String companyId,
    String? successUrl,
    String? cancelUrl,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('createStripeCheckoutSession')
          .call<dynamic>({
        'companyId': companyId,
        if (successUrl != null) 'successUrl': successUrl,
        if (cancelUrl != null) 'cancelUrl': cancelUrl,
      });

      final data = result.data as Map<String, dynamic>?;

      if (data == null) {
        return null;
      }

      return data['sessionUrl'] as String?;
    } catch (e) {
      throw SubscriptionException(
        'Failed to create checkout session: $e',
      );
    }
  }

  /// Gets the current subscription status for a company
  /// Optionally syncs with Stripe to get the latest data
  Future<SubscriptionStatus?> getSubscriptionStatus({
    required String companyId,
    bool syncWithStripe = false,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('getCompanySubscriptionStatus')
          .call<dynamic>({
        'companyId': companyId,
        'syncWithStripe': syncWithStripe,
      });

      final data = result.data as Map<String, dynamic>?;
      if (data == null) return null;

      return SubscriptionStatus.fromJson(data);
    } catch (e) {
      throw SubscriptionException(
        'Failed to get subscription status: $e',
      );
    }
  }

  /// Cancels a company subscription
  Future<bool> cancelSubscription({
    required String companyId,
    bool cancelImmediately = false,
    String? reason,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('cancelCompanySubscription')
          .call<dynamic>({
        'companyId': companyId,
        'cancelImmediately': cancelImmediately,
        if (reason != null) 'reason': reason,
      });

      final data = result.data as Map<String, dynamic>?;
      return data?['success'] == true;
    } catch (e) {
      throw SubscriptionException(
        'Failed to cancel subscription: $e',
      );
    }
  }

  /// Extends trial period (Admin only)
  Future<ExtendTrialResult?> extendTrial({
    required String companyId,
    required int extensionDays,
    String? reason,
  }) async {
    try {
      final result =
          await _functions.httpsCallable('extendCompanyTrial').call<dynamic>({
        'companyId': companyId,
        'extensionDays': extensionDays,
        if (reason != null) 'reason': reason,
      });

      final data = result.data as Map<String, dynamic>?;
      if (data == null) return null;

      return ExtendTrialResult.fromJson(data);
    } catch (e) {
      throw SubscriptionException(
        'Failed to extend trial: $e',
      );
    }
  }

  /// Creates a Stripe Customer Portal session
  /// Returns the portal URL to redirect the user to
  /// The portal allows users to manage their subscription, payment methods,
  /// and invoices
  Future<String?> createPortalSession({
    required String companyId,
    required String returnUrl,
  }) async {
    try {
      final result = await _functions
          .httpsCallable('createCustomerPortalSession')
          .call<dynamic>({
        'companyId': companyId,
        'returnUrl': returnUrl,
      });

      final data = result.data as Map<String, dynamic>?;
      if (data == null) {
        throw SubscriptionException(
          'Failed to create portal session: Received null response from server',
        );
      }

      final sessionUrl = data['sessionUrl'] as String?;
      if (sessionUrl == null || sessionUrl.isEmpty) {
        throw SubscriptionException(
          'Failed to create portal session: No session URL returned',
        );
      }

      return sessionUrl;
    } catch (e) {
      throw SubscriptionException(
        'Failed to create portal session: $e',
      );
    }
  }
}

/// Subscription status returned from Cloud Functions
class SubscriptionStatus {
  const SubscriptionStatus({
    required this.companyId,
    required this.subscriptionStatus,
    required this.termsAccepted,
    required this.canCreateDiscounts,
    this.subscriptionPlan,
    this.trialStartedAt,
    this.trialExpiresAt,
    this.subscriptionStartedAt,
    this.subscriptionExpiresAt,
    this.syncError,
  });

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatus(
      companyId: json['companyId'] as String,
      subscriptionStatus: json['subscriptionStatus'] as String,
      subscriptionPlan: json['subscriptionPlan'] as String?,
      trialStartedAt: json['trialStartedAt'] != null
          ? DateTime.parse(json['trialStartedAt'] as String)
          : null,
      trialExpiresAt: json['trialExpiresAt'] != null
          ? DateTime.parse(json['trialExpiresAt'] as String)
          : null,
      subscriptionStartedAt: json['subscriptionStartedAt'] != null
          ? DateTime.parse(json['subscriptionStartedAt'] as String)
          : null,
      subscriptionExpiresAt: json['subscriptionExpiresAt'] != null
          ? DateTime.parse(json['subscriptionExpiresAt'] as String)
          : null,
      termsAccepted: json['termsAccepted'] as bool? ?? false,
      canCreateDiscounts: json['canCreateDiscounts'] as bool? ?? false,
      syncError: json['syncError'] as String?,
    );
  }

  final String companyId;
  final String subscriptionStatus;
  final String? subscriptionPlan;
  final DateTime? trialStartedAt;
  final DateTime? trialExpiresAt;
  final DateTime? subscriptionStartedAt;
  final DateTime? subscriptionExpiresAt;
  final bool termsAccepted;
  final bool canCreateDiscounts;
  final String? syncError;

  bool get isTrialing => subscriptionStatus == 'trialing';
  bool get isActive => subscriptionStatus == 'active' || isTrialing;
  bool get needsPayment =>
      subscriptionStatus == 'incomplete' ||
      subscriptionStatus == 'past_due' ||
      subscriptionStatus == 'unpaid';

  int? get trialDaysRemaining {
    if (trialExpiresAt == null) return null;
    final remaining = trialExpiresAt!.difference(DateTime.now()).inDays;
    return remaining > 0 ? remaining : 0;
  }
}

/// Result from extending trial
class ExtendTrialResult {
  const ExtendTrialResult({
    required this.success,
    required this.newTrialExpires,
    required this.totalExtensionDays,
  });

  factory ExtendTrialResult.fromJson(Map<String, dynamic> json) {
    return ExtendTrialResult(
      success: json['success'] as bool,
      newTrialExpires: DateTime.parse(json['newTrialExpires'] as String),
      totalExtensionDays: json['totalExtensionDays'] as int,
    );
  }

  final bool success;
  final DateTime newTrialExpires;
  final int totalExtensionDays;
}

/// Exception thrown when subscription operations fail
class SubscriptionException implements Exception {
  SubscriptionException(this.message);

  final String message;

  @override
  String toString() => 'SubscriptionException: $message';
}
