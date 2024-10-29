import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/repositories/failure_repository.dart';

part 'some_failure_model.freezed.dart';

@freezed
@immutable
class SomeFailure with _$SomeFailure {
  factory SomeFailure({
    required Object? error,
    StackTrace? stack,
  }) = _SomeFailure;

  SomeFailure._() {
    failureRepository.sendError(this);
  }
  // factory SomeFailure.initial() = FailureInitial;

  factory SomeFailure.serverError({
    required Object? error,
    StackTrace? stack,
  }) = FailureServerError;

  factory SomeFailure.get({
    required Object? error,
    StackTrace? stack,
  }) = FailureGet;

  factory SomeFailure.send({
    required Object? error,
    StackTrace? stack,
  }) = FailureSend;

  factory SomeFailure.network({
    required Object? error,
    StackTrace? stack,
  }) = FailureNetwork;

  // authentication
  factory SomeFailure.unauthorized({
    required Object? error,
    StackTrace? stack,
  }) = FailureUnauthorized;

  factory SomeFailure.notFound({
    required Object? error,
    StackTrace? stack,
  }) = FailureNotFound;

  factory SomeFailure.duplicate({
    required Object? error,
    StackTrace? stack,
  }) = FailureDuplicate;

  factory SomeFailure.tooManyRequests({
    required Object? error,
    StackTrace? stack,
  }) = FailureTooManyRequests;

  factory SomeFailure.emailSendingFailed({
    required Object? error,
    StackTrace? stack,
  }) = FailureEmailSendingFailed;

  // Url
  factory SomeFailure.share({
    required Object? error,
    StackTrace? stack,
  }) = FailureShare;

  factory SomeFailure.link({
    required Object? error,
    StackTrace? stack,
  }) = FailureLink;

  factory SomeFailure.copy({
    required Object? error,
    StackTrace? stack,
  }) = FailureCopy;

  factory SomeFailure.wrongVerifyCode({
    Object? error,
    StackTrace? stack,
  }) = FailureWrongVerifyCode;

  final FailureRepository failureRepository = GetIt.I.get<FailureRepository>();
}
