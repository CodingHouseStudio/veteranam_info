import 'package:freezed_annotation/freezed_annotation.dart';

part 'some_failure_model.freezed.dart';

/// COMMENT: Class for adding an error name
@freezed
class SomeFailure with _$SomeFailure {
  const factory SomeFailure.initial() = _Initial;

  const factory SomeFailure.serverError() = _ServerError;

  const factory SomeFailure.unauthorized() = _Unauthorized;

  const factory SomeFailure.notFound() = _NotFound;

  const factory SomeFailure.duplicate() = _Duplicate;

  const factory SomeFailure.tooManyRequests() = _TooManyRequests;

  const factory SomeFailure.emailSendingFailed() = _EmailSendingFailed;
}
