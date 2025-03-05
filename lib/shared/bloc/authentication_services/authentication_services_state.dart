part of 'authentication_services_cubit.dart';

class AuthenticationServicesState extends Equatable {
  const AuthenticationServicesState({
    required this.status,
    this.failure,
  });
  final AuthenticationServicesStatus status;
  final SomeFailure? failure;
  @override
  List<Object?> get props => [status, failure];
}

enum AuthenticationServicesStatus {
  init,
  procesing,
  authentication,
  error,
}
