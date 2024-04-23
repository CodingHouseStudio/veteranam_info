import 'package:freezed_annotation/freezed_annotation.dart';

part 'some_failure_model.freezed.dart';

/// COMMENT: Class for adding an error name
@freezed
class SomeFailure with _$SomeFailure {
  const factory SomeFailure.initial() = FailureInitial;

  const factory SomeFailure.serverError() = FailureServerError;

  const factory SomeFailure.unauthorized() = FailureUnauthorized;

  const factory SomeFailure.notFound() = FailureNotFound;

  const factory SomeFailure.duplicate() = FailureDuplicate;

  const factory SomeFailure.tooManyRequests() = FailureTooManyRequests;

  const factory SomeFailure.emailSendingFailed() = FailureEmailSendingFailed;
}
