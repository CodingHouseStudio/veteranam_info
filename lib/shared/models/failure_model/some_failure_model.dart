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
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
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
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureServerError;

  factory SomeFailure.get({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureGet;

  factory SomeFailure.send({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureSend;

  factory SomeFailure.network({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureNetwork;

  // authentication
  factory SomeFailure.unauthorized({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureUnauthorized;

  factory SomeFailure.notFound({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureNotFound;

  factory SomeFailure.duplicate({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureDuplicate;

  factory SomeFailure.tooManyRequests({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureTooManyRequests;

  factory SomeFailure.emailSendingFailed({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureEmailSendingFailed;

  // Url
  factory SomeFailure.share({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureShare;

  factory SomeFailure.shareUnavailable({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureShareUnavailable;

  factory SomeFailure.link({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureLink;

  factory SomeFailure.copy({
    required Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureCopy;

  factory SomeFailure.wrongVerifyCode({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureWrongVerifyCode;

  factory SomeFailure.filter({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureFilter;

  factory SomeFailure.browserNotSupportPopupDialog({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureBrowserNotSupportPopupDialog;

  factory SomeFailure.emailInvalidFormat({
    Object? error,
    StackTrace? stack,
    ErrorLevelEnum? errorLevel,
    String? tag,
    String? tagKey,
    String? tag2,
    String? tag2Key,
    User? user,
    UserSetting? userSetting,
    String? data,
  }) = FailureEmailInvalidFormat;

  final FailureRepository failureRepository = GetIt.I.get<FailureRepository>();
}
