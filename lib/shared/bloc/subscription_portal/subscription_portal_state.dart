part of 'subscription_portal_cubit.dart';

class SubscriptionPortalState extends Equatable {
  const SubscriptionPortalState({
    required this.status,
    this.errorMessage,
  });

  final SubscriptionPortalStatus status;
  final String? errorMessage;

  @override
  List<Object?> get props => [status, errorMessage];
}

enum SubscriptionPortalStatus {
  initial,
  loading,
  success,
  failure,
}
