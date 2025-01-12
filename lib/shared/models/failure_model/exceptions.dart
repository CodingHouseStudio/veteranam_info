part of 'some_failure.dart';

/// COMMENT: Error handling classes
mixin _Exception {
  // static FailureRepository failureRepository
  //= GetIt.I.get<FailureRepository>();
  static void _send({
    required Object error,
    required StackTrace? stack,
    required User? user,
    required UserSetting? userSetting,
    required String? data,
    required String? tag,
    required String? tagKey,
    required String? tag2,
    required String? tag2Key,
    required ErrorLevelEnum errorLevel,
  }) {
    if (!KTest.isTest) {
      FailureRepository.onError(
        error: error,
        stack: stack,
        reason: null,
        information: null,
        errorLevel: errorLevel,
        tag: tag,
        tagKey: tagKey,
        data: data,
        tag2: tag2,
        tag2Key: tag2Key,
      );
    }
  }

  static SomeFailure getFromFirebasException({
    required firebase.FirebaseException error,
    required StackTrace? stack,
    required User? user,
    required UserSetting? userSetting,
    required String? data,
    required String? tag,
    required String? tagKey,
    required ErrorLevelEnum? errorLevel,
  }) {
    // final String tagValue;
    final String tagKeyValue;
    ErrorLevelEnum? errorLevelValue;
    final SomeFailure failure;
    if (error is firebase.FirebaseAuthException) {
      /// Authentication Error Start---------
      /// -----------------------------------
      tagKeyValue = ErrorText.firebaseAuthFailure;
      switch (error.code) {
        case 'invalid-email':
        case 'missing-email':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.emailInvalidFormat;
        case 'user-disabled':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.userDisable;
        case 'user-not-found':
        case 'invalid-credential':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.userNotFound;
        case 'wrong-password':
        case 'missing-password':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.passwordWrong;
        case 'weak-password':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.passwordWeak;
        case 'too-many-requests':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.tooManyRequests;
        case 'credential-already-in-use':
        case 'account-exists-with-different-credential':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.userDuplicate;
        case 'requires-recent-login':
          errorLevelValue = ErrorLevelEnum.warning;
          failure = SomeFailure.requiresRecentLogin;
        case 'email-already-in-use':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.userEmailDuplicate;
        case 'user-token-expired':
        case 'invalid-user-token':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.wrongVerifyCode;
        case 'network-request-failed':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.network;
        case 'provider-already-linked':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.providerAlreadyLinked;
        case 'internal-error':
        case 'permission-denied':
        case 'operation-not-allowed':
        default:
          errorLevelValue = null;
          failure = SomeFailure.serverError;
      }

      /// Authentication Error Finished---------
      /// --------------------------------------
    } else {
      tagKeyValue = ErrorText.firebaseFailure;
      switch (error.code) {
        case 'not-found':
        case 'object-not-found':
        case 'bucket-not-found':
        case 'project-not-found':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.dataNotFound;
        case 'already-exists':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.setExistData;
        case 'resource-exhausted':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.tooManyRequests;
        case 'unauthorized':
        case 'unauthenticated':
        case 'permission-denied':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.permission;
        case 'max-retries':
        case 'retry-limit-exceeded':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.maxRetries;
        case 'write-cancelled':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.loadFileCancel;
        case 'cancelled':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.cancelled;
        case 'invalid-argument':
        case 'unregistered':
        case 'expired-token':
        case 'invalid-checksum':
        case 'internal':
        case 'quota-exceeded':
        case 'mismatched-credential':
        case 'invalid-registration-token':
        case 'message-rate-exceeded':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.fcm;
        case 'deadline-exceeded':
        case 'disconnected':
        case 'network-error':
        case 'unavailable':
        case 'failed-precondition':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.network;
        case 'failed-service-worker-registration':
          errorLevelValue = ErrorLevelEnum.info;
          failure = SomeFailure.serviceWorkerRegistration;
        case 'unimplemented':
        case 'data-loss':
        case 'aborted':
        case 'unknown':
        case 'out-of-range':
        default:
          errorLevelValue = null;
          failure = SomeFailure.serverError;
      }
    }
    _send(
      error: error,
      stack: stack,
      user: user,
      userSetting: userSetting,
      data: data,
      tag: tag,
      tagKey: tagKey,
      tag2: failure._getValue,
      tag2Key: tagKeyValue,
      errorLevel: errorLevel ?? errorLevelValue ?? ErrorLevelEnum.error,
    );
    return failure;
  }

  static SomeFailure getException({
    required Object error,
    required StackTrace? stack,
    required User? user,
    required UserSetting? userSetting,
    required String? data,
    required String? tag,
    required String? tagKey,
    required ErrorLevelEnum? errorLevel,
  }) {
    final String tagKeyValue;
    ErrorLevelEnum? errorLevelValue;
    final SomeFailure failure;

    if (error is String) {
      tagKeyValue = ErrorText.stringException;
      errorLevelValue = ErrorLevelEnum.info;
      switch (error) {
        case 'Code is null':
          failure = SomeFailure.wrongVerifyCode;
        case 'Invalid input':
          failure = SomeFailure.invalidInput;
        default:
          failure = SomeFailure.serverError;
      }
    } else if (error is Exception) {
      final errorMessage = error.toString().toLowerCase();
      tagKeyValue = ErrorText.exceptionKey;
      if (errorMessage.contains('navigator.share()') ||
          errorMessage.contains('navigator.canshare()')) {
        switch (errorMessage
            .replaceFirst('navigator.share() ', '')
            .replaceFirst('navigator.canshare() ', '')
            .replaceFirst('exception: ', '')) {
          case 'failed: share() is already in progress':
          case "failed: failed to execute 'share' on "
                "'navigator': an earlier share has not yet completed.":
            failure = SomeFailure.shareInProgress;
            errorLevelValue = ErrorLevelEnum.info;
          case 'is unavailable':
          case 'is false':
            failure = SomeFailure.shareUnavailable;
            errorLevelValue = ErrorLevelEnum.info;
          case 'failed: share()':
          default:
            failure = SomeFailure.share;
        }
      } else if (errorMessage.contains('timeoutexception')) {
        failure = SomeFailure.timeout;
        errorLevelValue = ErrorLevelEnum.warning;
      } else if (errorMessage.contains('socketexception')) {
        failure = SomeFailure.network;
        errorLevelValue = ErrorLevelEnum.warning;
      } else if (errorMessage.contains('formatexception')) {
        failure = SomeFailure.format;
        errorLevelValue = ErrorLevelEnum.warning;
      } else if (errorMessage.contains('unimplementederror')) {
        failure = SomeFailure.unimplementedFeature;
        errorLevelValue = ErrorLevelEnum.error;
      } else if (errorMessage.contains('connection refused') ||
          errorMessage.contains('no internet') ||
          errorMessage.contains('network-request') ||
          errorMessage.contains('resource limit exceeded') ||
          errorMessage.contains('offline') ||
          errorMessage.contains('failed-precondition')) {
        failure = SomeFailure.network;
        errorLevelValue = ErrorLevelEnum.info;
      } else if (errorMessage.contains('permission-denied')) {
        failure = SomeFailure.permission;
        errorLevelValue = ErrorLevelEnum.info;
      } else if (errorMessage.contains('outofmemoryerror')) {
        failure = SomeFailure.assertion;
        errorLevelValue = ErrorLevelEnum.fatal;
      } else {
        failure = SomeFailure.serverError;
      }
    } else if (error is Error) {
      tagKeyValue = ErrorText.failure;
      switch (error.runtimeType) {
        case AssertionError:
          failure = SomeFailure.assertion;
          errorLevelValue = ErrorLevelEnum.fatal;
        case TypeError:
          failure = SomeFailure.type;
          errorLevelValue = ErrorLevelEnum.error;
        case NoSuchMethodError:
          failure = SomeFailure.noSuchMethodError;
          errorLevelValue = ErrorLevelEnum.error;
        default:
          failure = SomeFailure.serverError;
          errorLevelValue = ErrorLevelEnum.fatal;
      }
    } else {
      tagKeyValue = ErrorText.unknownKey;
      failure = SomeFailure.serverError;
      errorLevelValue = ErrorLevelEnum.error;
    }

    _send(
      error: error,
      stack: stack,
      user: user,
      userSetting: userSetting,
      data: data,
      tag: tag,
      tagKey: tagKey,
      tag2: failure._getValue,
      tag2Key: tagKeyValue,
      errorLevel: errorLevel ?? errorLevelValue ?? ErrorLevelEnum.error,
    );

    return failure;
  }
}

// /// COMMENT: Error handling classes
// class SendFailure {
//   SendFailure({
//     required this.status,
//   });

//   factory SendFailure.fromCode({
//     required firebase.FirebaseException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'invalid-argument':
//       case 'missing-argument':
//       case 'timeout':
//       case 'canceled':
//       case 'permission-denied':
//       case 'quota-exceeded':
//       case 'internal-error':
//       case 'invalid-file-type':
//       case 'file-too-large':
//         return SendFailure(
//           status: SomeFailure._send(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.sendFailur}(${ErrorText.sendError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//       case 'network-error':
//         return SendFailure(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.sendFailur}(${ErrorText.networkError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       default:
//         return SendFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.sendFailur}(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }

//   final SomeFailure status;
// }

// class GetFailur {
//   GetFailur({
//     required this.status,
//   });

//   factory GetFailur.fromCode({
//     required firebase.FirebaseException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'not-found':
//         return GetFailur(
//           status: SomeFailure._notFound(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.getFailur}'
//                 '(${ErrorText.userNotFound}'
//                 '${ErrorText.firebaseException})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'missing-argument':
//       case 'timeout':
//       case 'canceled':
//       case 'permission-denied':
//       case 'out-of-range':
//       case 'data-error':
//       case 'internal-error':
//       case 'invalid-argument':
//         return GetFailur(
//           status: SomeFailure._get(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.getFailur}'
//                 '(${ErrorText.getError} ${ErrorText.firebase
// .firebaseException})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//       case 'network-error':
//         return GetFailur(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.getFailur}'
//                 '(${ErrorText.networkError} ${ErrorText.firebase.
// firebaseException})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       default:
//         return GetFailur(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.getFailur}'
//                 '(${ErrorText.unkownErorr} ${ErrorText.firebase.
// firebaseException})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }
//   factory GetFailur.fromMessage({
//     required Object error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     if (error is TypeError) {
//       return GetFailur(
//         status: SomeFailure._serverError(
//           error: error,
//           stack: stack,
//           tag: '${ErrorText.getFailur}(${ErrorText.unkownErorr} TypeError)',
//           tagKey: ErrorText.exceptionsFolderKey,
//           user: user,
//           userSetting: userSetting,
//           data: data,
//           tag2: tag,
//           tag2Key: tagKey,
//         ),
//       );
//     } else {
//       return GetFailur(
//         status: SomeFailure._serverError(
//           error: error,
//           stack: stack,
//           tag: '${ErrorText.getFailur}(${ErrorText.serverError})',
//           tagKey: ErrorText.exceptionsFolderKey,
//           user: user,
//           userSetting: userSetting,
//           data: data,
//           tag2: tag,
//           tag2Key: tagKey,
//         ),
//       );
//     }
//   }

//   final SomeFailure status;
// }

// /// {@template sign_up_with_email_and_password_failure}
// /// Thrown during the sign up process if a failure occurs.
// /// {@endtemplate}
// class SignUpWithEmailAndPasswordFailure {
//   /// {@macro sign_up_with_email_and_password_failure}
//   const SignUpWithEmailAndPasswordFailure({required this.status});

//   factory SignUpWithEmailAndPasswordFailure.fromCode({
//     required FirebaseAuthException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'email-already-in-use':
//         return SignUpWithEmailAndPasswordFailure(
//           status: SomeFailure._userDuplicate(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
//                 '(${ErrorText.duplicateError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'operation-not-allowed':
//       case 'invalid-email':
//       case 'user-disabled':
//       case 'weak-password':
//         return SignUpWithEmailAndPasswordFailure(
//           status: SomeFailure._emailInvalidFormat(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'network-error':
//         return SignUpWithEmailAndPasswordFailure(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
//                 '(${ErrorText.networkError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       default:
//         return SignUpWithEmailAndPasswordFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }

//   final SomeFailure status;
// }

// class LogInWithEmailAndPasswordFailure {
//   /// {@macro log_in_with_email_and_password_failure}
//   const LogInWithEmailAndPasswordFailure({required this.status});

//   factory LogInWithEmailAndPasswordFailure.fromCode({
//     required FirebaseAuthException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'user-disabled':
//       case 'invalid-email':
//       case 'user-not-found':
//       case 'invalid-credential':
//         return LogInWithEmailAndPasswordFailure(
//           status: SomeFailure._notFound(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.logInWithEmailAndPasswordFailure}'
//                 '(${ErrorText.userNotFound})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'wrong-password':
//         return LogInWithEmailAndPasswordFailure(
//           status: SomeFailure._passwordWrong(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'network-error':
//         return LogInWithEmailAndPasswordFailure(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.logInWithEmailAndPasswordFailure}'
//                 '(${ErrorText.networkError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       default:
//         return LogInWithEmailAndPasswordFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.logInWithEmailAndPasswordFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }

//   final SomeFailure status;
// }

// /// Thrown during the logout process if a failure occurs.
// // class LogOutFailure  {}
// class LogOutFailure {
//   const LogOutFailure({required this.status});

//   factory LogOutFailure.fromCode({
//     required firebase.FirebaseException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'missing-argument':
//       case 'timeout':
//       case 'canceled':
//       case 'unauthenticated':
//       case 'expired-token':
//       case 'invalid-token':
//       case 'user-not-found':
//       case 'internal-error':
//         return LogOutFailure(
//           status: SomeFailure._unauthorized(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.logOutFailure}(${ErrorText.
// unauthirizedError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//       case 'network-error':
//         return LogOutFailure(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.logOutFailure}(${ErrorText.networkError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       default:
//         return LogOutFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.logOutFailure}(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }

//   final SomeFailure status;
// }

// class SignUpWithGoogleFailure {
//   const SignUpWithGoogleFailure({required this.status});

//   factory SignUpWithGoogleFailure.fromCode({
//     required FirebaseAuthException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'account-exists-with-different-credential':
//       case 'user-not-found':
//       case 'invalid-email':
//       case 'wrong-password':
//       case 'invalid-credential':
//       case 'user-disabled':
//       case 'invalid-verification-code':
//       case 'invalid-verification-id':
//         return SignUpWithGoogleFailure(
//           status: SomeFailure._notFound(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithGoogleFailure}'
//                 '(${ErrorText.userNotFound})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'operation-not-allowed':
//         return SignUpWithGoogleFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithGoogleFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//       case 'network-error':
//         return SignUpWithGoogleFailure(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithGoogleFailure}'
//                 '(${ErrorText.networkError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'popup-closed-by-user':
//       case 'popup-blocked':
//       case 'provider-already-linked':
//         return SignUpWithGoogleFailure(
//           status: SomeFailure._browserNotSupportPopupDialog(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithGoogleFailure}'
//                 '(${ErrorText.browserNotSupportPopupDialogError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'cancelled-popup-request':
//         return const SignUpWithGoogleFailure(status: null);
//       default:
//         return SignUpWithGoogleFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithGoogleFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }

//   final SomeFailure? status;
// }

// class SignUpWithFacebookFailure {
//   const SignUpWithFacebookFailure({required this.status});

//   factory SignUpWithFacebookFailure.fromCode({
//     required FirebaseAuthException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'account-exists-with-different-credential':
//       case 'user-not-found':
//       case 'wrong-password':
//       case 'invalid-credential':
//       case 'user-disabled':
//       case 'invalid-verification-code':
//       case 'invalid-verification-id':
//         return SignUpWithFacebookFailure(
//           status: SomeFailure._notFound(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithFacebookFailure}'
//                 '(${ErrorText.userNotFound})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'operation-not-allowed':
//         return SignUpWithFacebookFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithFacebookFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//       case 'network-error':
//         return SignUpWithFacebookFailure(
//           status: SomeFailure._network(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithFacebookFailure}'
//                 '(${ErrorText.networkError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'popup-closed-by-user':
//       case 'popup-blocked':
//       case 'provider-already-linked':
//         return SignUpWithFacebookFailure(
//           status: SomeFailure._browserNotSupportPopupDialog(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithFacebookFailure}'
//                 '(${ErrorText.browserNotSupportPopupDialogError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       case 'cancelled-popup-request':
//         return const SignUpWithFacebookFailure(status: null);
//       default:
//         return SignUpWithFacebookFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.signUpWithFacebookFailure}'
//                 '(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//   }

//   final SomeFailure? status;
// }

// class ShareFailure {
//   const ShareFailure({required this.status});

//   factory ShareFailure.fromCode({
//     required Object error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     if (error is Exception) {
//       switch (error.toString()) {
//         case 'Exception: Navigator.share() failed: share()'
//               ' is already in progress':
//           return const ShareFailure(
//             status: null,
//           );
//         case 'Exception: Navigator.canShare() is unavailable':
//           return ShareFailure(
//             status: SomeFailure._shareUnavailable(
//               error: error,
//               stack: stack,
//               tag: '${ErrorText.shareFailure}'
//                   '(${ErrorText.shareUnavailableError})',
//               tagKey: ErrorText.exceptionsFolderKey,
//               user: user,
//               userSetting: userSetting,
//               data: data,
//               tag2: tag,
//               tag2Key: tagKey,
//               errorLevel: ErrorLevelEnum.info,
//             ),
//           );
//         default:
//           return ShareFailure(
//             status: SomeFailure._share(
//               error: error,
//               stack: stack,
//               tag: '${ErrorText.shareFailure}(${ErrorText.shareError})',
//               tagKey: ErrorText.exceptionsFolderKey,
//               user: user,
//               userSetting: userSetting,
//               data: data,
//               tag2: tag,
//               tag2Key: tagKey,
//             ),
//           );
//       }
//     } else {
//       return ShareFailure(
//         status: SomeFailure._serverError(
//           error: error,
//           stack: stack,
//           tag: '${ErrorText.shareFailure}(${ErrorText.serverError})',
//           tagKey: ErrorText.exceptionsFolderKey,
//           user: user,
//           userSetting: userSetting,
//           data: data,
//           tag2: tag,
//           tag2Key: tagKey,
//         ),
//       );
//     }
//   }

//   final SomeFailure? status;
// }

// class VerifyCodeFailure {
//   const VerifyCodeFailure({required this.status});

//   factory VerifyCodeFailure.fromCode({
//     required firebase.FirebaseException error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.code) {
//       case 'invalid-action-code':
//         return VerifyCodeFailure(
//           status: SomeFailure._wrongVerifyCode(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.verifyCodeFailure}'
//                 '(${ErrorText.wrongVerifyCodeError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//             errorLevel: ErrorLevelEnum.info,
//           ),
//         );
//       default:
//         return VerifyCodeFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.verifyCodeFailure}(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//     // return VerifyCodeFailure(
//     //   status: SomeFailure._serverError(error: error, stack: stack),
//     // );
//   }

//   final SomeFailure status;
// }

// class FcmTokenGetFailure {
//   const FcmTokenGetFailure({required this.status});

//   factory FcmTokenGetFailure.fromCode({
//     required Object error,
//     StackTrace? stack,
//     custom_user.User? user,
//     custom_user.UserSetting? userSetting,
//     String? data,
//     String? tag,
//     String? tagKey,
//   }) {
//     switch (error.toString()) {
//       case "AbortError: Failed to execute 'subscribe' on 'PushManager':"
//             ' Subscription failed - no active Service Worker':
//         return const FcmTokenGetFailure(
//           status: null,
//         );
//       default:
//         return FcmTokenGetFailure(
//           status: SomeFailure._serverError(
//             error: error,
//             stack: stack,
//             tag: '${ErrorText.verifyCodeFailure}(${ErrorText.serverError})',
//             tagKey: ErrorText.exceptionsFolderKey,
//             user: user,
//             userSetting: userSetting,
//             data: data,
//             tag2: tag,
//             tag2Key: tagKey,
//           ),
//         );
//     }
//     // return VerifyCodeFailure(
//     //   status: SomeFailure._serverError(error: error, stack: stack),
//     // );
//   }

//   final SomeFailure? status;
// }
