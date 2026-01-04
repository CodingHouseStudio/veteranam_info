part of 'subscription_checkout_cubit.dart';

class SubscriptionCheckoutState extends Equatable {
  const SubscriptionCheckoutState({
    required this.status,
    this.error,
  });

  final SubscriptionCheckoutStatus status;
  final SubscriptionCheckoutError? error;

  @override
  List<Object?> get props => [status, error];
}

enum SubscriptionCheckoutStatus {
  initial,
  loading,
  success,
  failure,
}
