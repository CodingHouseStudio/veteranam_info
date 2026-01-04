part of 'subscription_portal_cubit.dart';

class SubscriptionPortalState extends Equatable {
  const SubscriptionPortalState({
    required this.status,
    this.error,
  });

  final SubscriptionPortalStatus status;
  final SubscriptionPortalError? error;

  @override
  List<Object?> get props => [status, error];
}

enum SubscriptionPortalStatus {
  initial,
  loading,
  success,
  failure,
}
