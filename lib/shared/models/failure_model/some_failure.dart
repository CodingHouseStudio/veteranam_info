import 'package:flutter/services.dart';

import 'package:firebase_auth/firebase_auth.dart' as firebase;

import 'package:veteranam/shared/shared_dart.dart';

// import 'package:veteranam/shared/constants/text/error_text.dart';

part 'exceptions.dart';
part 'some_failure_extension.dart';

enum SomeFailure with _Exception {
  serverError,
  noSuchMethodError,
  timeout,
  type,
  assertion,
  unimplementedFeature,
  format,
  get,
  send,
  network,
  maxRetries,
  loadFileCancel,
  cancelled,
  filter,
  fcm,
  unauthorized,
  userNotFound,
  userDuplicate,
  requiresRecentLogin,
  userEmailDuplicate,
  tooManyRequests,
  permission,
  emailSendingFailed,
  share,
  shareUnavailable,
  link,
  copy,
  wrongVerifyCode,
  invalidInput,
  browserNotSupportPopupDialog,
  popupCancelled,
  emailInvalidFormat,
  passwordWrong,
  passwordWeak,
  userDisable,
  dataNotFound,
  wrongID,
  linkWrong,
  shareInProgress,
  providerAlreadyLinked,
  serviceWorkerRegistration,
  unsupported,
  copyNotSupport,
  // notFound,
  setExistData;

  factory SomeFailure.value({
    required Object error,
    StackTrace? stack,
    User? user,
    UserSetting? userSetting,
    String? data,
    String? tag,
    String? tagKey,
    ErrorLevelEnum? errorLevel,
  }) {
    return _Exception.getException(
      error: error,
      stack: stack,
      data: data,
      tag: tag,
      tagKey: tagKey,
      user: user,
      userSetting: userSetting,
      errorLevel: errorLevel,
    );
  }

  String get _getValue {
    switch (this) {
      case SomeFailure.serverError:
        return ErrorText.serverError;
      case SomeFailure.get:
        return ErrorText.getError;
      case SomeFailure.send:
        return ErrorText.sendError;
      case SomeFailure.network:
        return ErrorText.networkError;
      case SomeFailure.maxRetries:
        return ErrorText.maxRetries;
      case SomeFailure.loadFileCancel:
        return ErrorText.writeCancel;
      case SomeFailure.cancelled:
        return ErrorText.canceled;
      case SomeFailure.fcm:
        return ErrorText.fcmError;
      case SomeFailure.unauthorized:
        return ErrorText.unauthorized;
      case SomeFailure.userNotFound:
        return ErrorText.userNotFound;
      case SomeFailure.userDuplicate:
        return ErrorText.userDuplicate;
      case SomeFailure.requiresRecentLogin:
        return ErrorText.requiresRecentLogin;
      case SomeFailure.userEmailDuplicate:
        return ErrorText.userEmailDuplicate;
      case SomeFailure.tooManyRequests:
        return ErrorText.tooManyRequestsError;
      case SomeFailure.permission:
        return ErrorText.permission;
      case SomeFailure.emailSendingFailed:
        return ErrorText.emailSendingFailedError;
      case SomeFailure.share:
        return ErrorText.shareError;
      case SomeFailure.shareUnavailable:
        return ErrorText.shareUnavailableError;
      case SomeFailure.link:
        return ErrorText.linkError;
      case SomeFailure.copy:
        return ErrorText.copyError;
      case SomeFailure.wrongVerifyCode:
        return ErrorText.wrongVerifyCodeError;
      case SomeFailure.filter:
        return ErrorText.filterError;
      case SomeFailure.browserNotSupportPopupDialog:
        return ErrorText.browserNotSupportPopupDialogError;
      case SomeFailure.emailInvalidFormat:
        return ErrorText.emailInvalidFormat;
      case SomeFailure.passwordWrong:
        return ErrorText.wrongPassword;
      case SomeFailure.passwordWeak:
        return ErrorText.weakPassword;
      case SomeFailure.userDisable:
        return ErrorText.userDisable;
      case SomeFailure.dataNotFound:
        return ErrorText.dataNotFound;
      case SomeFailure.wrongID:
        return ErrorText.wrongID;
      case SomeFailure.linkWrong:
        return ErrorText.linkWrong;
      case SomeFailure.setExistData:
        return ErrorText.setExistData;
      case SomeFailure.shareInProgress:
        return ErrorText.shareInProgress;
      case SomeFailure.noSuchMethodError:
        return ErrorText.noSuchMethodError;
      case SomeFailure.timeout:
        return ErrorText.timeout;
      case SomeFailure.type:
        return ErrorText.type;
      case SomeFailure.assertion:
        return ErrorText.assertion;
      case SomeFailure.unimplementedFeature:
        return ErrorText.unimplementedFeature;
      case SomeFailure.format:
        return ErrorText.format;
      case SomeFailure.invalidInput:
        return ErrorText.invalidInput;
      case SomeFailure.providerAlreadyLinked:
        return ErrorText.providerAlreadyLinked;
      case SomeFailure.serviceWorkerRegistration:
        return ErrorText.serviceWorkerRegistration;
      case SomeFailure.unsupported:
        return ErrorText.unsupportedError;
      case SomeFailure.copyNotSupport:
        return ErrorText.copyNotSupport;
      case SomeFailure.popupCancelled:
        return ErrorText.popupCancelled;
    }
  }

  // factory SomeFailure._serverError({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureServerError;

  // SomeFailure.__() {
  //   failureRepository.sendError(this);
  // }

  // factory SomeFailure._get({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureGet;

  // factory SomeFailure._send({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureSend;

  // factory SomeFailure._network({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureNetwork;

  // factory SomeFailure._maxRetries({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureMaxRetries;

  // factory SomeFailure._loadFileCancel({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureLoadFileCancel;

  // factory SomeFailure._cancelled({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureCancelled;

  // factory SomeFailure._fcm({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureFCM;

  // // authentication
  // factory SomeFailure._unauthorized({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureUnauthorized;

  // factory SomeFailure._userNotFound({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureUserNotFound;

  // factory SomeFailure._userDuplicate({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureUserDuplicate;

  // factory SomeFailure._requiresRecentLogin({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureRequiresRecentLogin;

  // factory SomeFailure._userEmailDuplicate({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureUserEmailDuplicate;

  // factory SomeFailure._tooManyRequests({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureTooManyRequests;

  // factory SomeFailure._permission({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailurePermission;

  // factory SomeFailure._emailSendingFailed({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureEmailSendingFailed;

  // // Url
  // factory SomeFailure._share({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureShare;

  // factory SomeFailure._shareUnavailable({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureShareUnavailable;

  // factory SomeFailure._link({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureLink;

  // factory SomeFailure._copy({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureCopy;

  // factory SomeFailure._wrongVerifyCode({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureWrongVerifyCode;

  // factory SomeFailure._filter({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureFilter;

  // factory SomeFailure._browserNotSupportPopupDialog({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureBrowserNotSupportPopupDialog;

  // factory SomeFailure._emailInvalidFormat({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureEmailInvalidFormat;

  // factory SomeFailure._passwordWrong({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailurePasswordWrong;

  // factory SomeFailure._passwordWeak({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailurePasswordWeak;

  // factory SomeFailure._userDisable({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureUserDisable;

  // factory SomeFailure._dataNotFound({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureDataNotFound;

  // factory SomeFailure._setExistData({
  //   required Object? error,
  //   StackTrace? stack,
  //   ErrorLevelEnum? errorLevel,
  //   String? tag,
  //   String? tagKey,
  //   String? tag2,
  //   String? tag2Key,
  //   User? user,
  //   UserSetting? userSetting,
  //   String? data,
  // }) = _FailureSetExistData;
}
