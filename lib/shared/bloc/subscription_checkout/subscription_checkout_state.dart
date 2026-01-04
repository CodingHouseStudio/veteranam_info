part of 'subscription_checkout_cubit.dart';

class SubscriptionCheckoutState extends Equatable {
  const SubscriptionCheckoutState({
    required this.status,
    this.errorMessage,
  });

  final SubscriptionCheckoutStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
}

enum SubscriptionCheckoutStatus {
  initial,
  loading,
  success,
  failure,
}
