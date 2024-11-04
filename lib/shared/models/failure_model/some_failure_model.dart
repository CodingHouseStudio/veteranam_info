import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:veteranam/shared/shared_dart.dart';

part 'some_failure_model.freezed.dart';

@freezed
@immutable
class SomeFailure with _$SomeFailure {
  factory SomeFailure({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = _SomeFailure;

  SomeFailure._() {
    failureRepository.sendError(this);
  }
  // factory SomeFailure.initial() = FailureInitial;

  factory SomeFailure.serverError({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureServerError;

  factory SomeFailure.get({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureGet;

  factory SomeFailure.send({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureSend;

  factory SomeFailure.network({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureNetwork;

  // authentication
  factory SomeFailure.unauthorized({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureUnauthorized;

  factory SomeFailure.notFound({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureNotFound;

  factory SomeFailure.duplicate({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureDuplicate;

  factory SomeFailure.tooManyRequests({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureTooManyRequests;

  factory SomeFailure.emailSendingFailed({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureEmailSendingFailed;

  // Url
  factory SomeFailure.share({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureShare;

  factory SomeFailure.link({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureLink;

  factory SomeFailure.copy({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureCopy;

  factory SomeFailure.wrongVerifyCode({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    User? user,
    UserSetting? userSetting,
  }) = FailureWrongVerifyCode;

  final FailureRepository failureRepository = GetIt.I.get<FailureRepository>();
}
