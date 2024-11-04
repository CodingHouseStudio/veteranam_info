import 'package:firebase_auth/firebase_auth.dart';
import 'package:veteranam/shared/constants/text/error_text.dart';

import 'package:veteranam/shared/models/failure_model/some_failure_model.dart';
import 'package:veteranam/shared/models/models.dart' as custom_user;

/// COMMENT: Error handling classes
class SendFailure {
  SendFailure({
    required this.status,
  });

  factory SendFailure.fromCode({
    required FirebaseException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'invalid-argument':
      case 'missing-argument':
      case 'timeout':
      case 'canceled':
      case 'permission-denied':
      case 'quota-exceeded':
      case 'internal-error':
      case 'invalid-file-type':
      case 'file-too-large':
        return SendFailure(
          status: SomeFailure.send(
            error: error,
            stack: stack,
            tag: '${ErrorText.sendFailur}(${ErrorText.sendError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'network-error':
        return SendFailure(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.sendFailur}(${ErrorText.networkError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return SendFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.sendFailur}(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }

  final SomeFailure status;
}

class GetFailur {
  GetFailur({
    required this.status,
  });

  factory GetFailur.fromCode({
    required FirebaseException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'not-found':
        return GetFailur(
          status: SomeFailure.notFound(
            error: error,
            stack: stack,
            tag: '${ErrorText.getFailur}'
                '(${ErrorText.notFoundError} ${ErrorText.firebaseException})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'missing-argument':
      case 'timeout':
      case 'canceled':
      case 'permission-denied':
      case 'out-of-range':
      case 'data-error':
      case 'internal-error':
      case 'invalid-argument':
        return GetFailur(
          status: SomeFailure.get(
            error: error,
            stack: stack,
            tag: '${ErrorText.getFailur}'
                '(${ErrorText.getError} ${ErrorText.firebaseException})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'network-error':
        return GetFailur(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.getFailur}'
                '(${ErrorText.networkError} ${ErrorText.firebaseException})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return GetFailur(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.getFailur}'
                '(${ErrorText.unkownErorr} ${ErrorText.firebaseException})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }
  factory GetFailur.fromMessage({
    required Object error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    if (error is TypeError) {
      return GetFailur(
        status: SomeFailure.serverError(
          error: error,
          stack: stack,
          tag: '${ErrorText.getFailur}(${ErrorText.unkownErorr} TypeError)',
          tagKey: ErrorText.exceptionsFolderKey,
          user: user,
          userSetting: userSetting,
        ),
      );
    } else {
      return GetFailur(
        status: SomeFailure.serverError(
          error: error,
          stack: stack,
          tag: '${ErrorText.getFailur}(${ErrorText.serverError})',
          tagKey: ErrorText.exceptionsFolderKey,
          user: user,
          userSetting: userSetting,
        ),
      );
    }
  }

  final SomeFailure status;
}

/// {@template sign_up_with_email_and_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure({required this.status});

  factory SignUpWithEmailAndPasswordFailure.fromCode({
    required FirebaseAuthException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.duplicate(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
                '(${ErrorText.duplicateError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'operation-not-allowed':
      case 'invalid-email':
      case 'user-disabled':
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'network-error':
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
                '(${ErrorText.networkError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithEmailAndPasswordFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }

  final SomeFailure status;
}

class LogInWithEmailAndPasswordFailure {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure({required this.status});

  factory LogInWithEmailAndPasswordFailure.fromCode({
    required FirebaseAuthException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'user-disabled':
      case 'invalid-email':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return LogInWithEmailAndPasswordFailure(
          status: SomeFailure.notFound(
            error: error,
            stack: stack,
            tag: '${ErrorText.logInWithEmailAndPasswordFailure}'
                '(${ErrorText.notFoundError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'network-error':
        return LogInWithEmailAndPasswordFailure(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.logInWithEmailAndPasswordFailure}'
                '(${ErrorText.networkError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return LogInWithEmailAndPasswordFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.logInWithEmailAndPasswordFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }

  final SomeFailure status;
}

/// Thrown during the logout process if a failure occurs.
// class LogOutFailure  {}
class LogOutFailure {
  const LogOutFailure({required this.status});

  factory LogOutFailure.fromCode({
    required FirebaseException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'missing-argument':
      case 'timeout':
      case 'canceled':
      case 'unauthenticated':
      case 'expired-token':
      case 'invalid-token':
      case 'user-not-found':
      case 'internal-error':
        return LogOutFailure(
          status: SomeFailure.unauthorized(
            error: error,
            stack: stack,
            tag: '${ErrorText.logOutFailure}(${ErrorText.unauthirizedError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'network-error':
        return LogOutFailure(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.logOutFailure}(${ErrorText.networkError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return LogOutFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.logOutFailure}(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }

  final SomeFailure status;
}

class SignUpWithGoogleFailure {
  const SignUpWithGoogleFailure({required this.status});

  factory SignUpWithGoogleFailure.fromCode({
    required FirebaseAuthException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'account-exists-with-different-credential':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'user-disabled':
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return SignUpWithGoogleFailure(
          status: SomeFailure.notFound(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithGoogleFailure}'
                '(${ErrorText.notFoundError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'operation-not-allowed':
        return SignUpWithGoogleFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithGoogleFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'network-error':
        return SignUpWithGoogleFailure(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithGoogleFailure}'
                '(${ErrorText.networkError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return SignUpWithGoogleFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithGoogleFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }

  final SomeFailure status;
}

class SignUpWithFacebookFailure {
  const SignUpWithFacebookFailure({required this.status});

  factory SignUpWithFacebookFailure.fromCode({
    required FirebaseAuthException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'account-exists-with-different-credential':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'user-disabled':
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return SignUpWithFacebookFailure(
          status: SomeFailure.notFound(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithFacebookFailure}'
                '(${ErrorText.notFoundError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      case 'operation-not-allowed':
        return SignUpWithFacebookFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithFacebookFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
          ),
        );
      case 'network-error':
        return SignUpWithFacebookFailure(
          status: SomeFailure.network(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithFacebookFailure}'
                '(${ErrorText.networkError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return SignUpWithFacebookFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.signUpWithFacebookFailure}'
                '(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
  }

  final SomeFailure status;
}

class ShareFailure {
  const ShareFailure({required this.status});

  factory ShareFailure.fromCode({
    required Object error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    if (error is Exception) {
      switch (error.toString()) {
        case 'Exception: Navigator.canShare() is unavailable':
          return const ShareFailure(
            status: null,
          );
        default:
          return ShareFailure(
            status: SomeFailure.share(
              error: error,
              stack: stack,
              tag: '${ErrorText.shareFailure}(${ErrorText.shareError})',
              tagKey: ErrorText.exceptionsFolderKey,
              user: user,
              userSetting: userSetting,
            ),
          );
      }
    } else {
      return ShareFailure(
        status: SomeFailure.serverError(
          error: error,
          stack: stack,
          tag: '${ErrorText.shareFailure}(${ErrorText.serverError})',
          tagKey: ErrorText.exceptionsFolderKey,
          user: user,
          userSetting: userSetting,
        ),
      );
    }
  }

  final SomeFailure? status;
}

class VerifyCodeFailure {
  const VerifyCodeFailure({required this.status});

  factory VerifyCodeFailure.fromCode({
    required FirebaseException error,
    StackTrace? stack,
    custom_user.User? user,
    custom_user.UserSetting? userSetting,
  }) {
    switch (error.code) {
      case 'invalid-action-code':
        return VerifyCodeFailure(
          status: SomeFailure.wrongVerifyCode(
            error: error,
            stack: stack,
            tag: '${ErrorText.verifyCodeFailure}'
                '(${ErrorText.wrongVerifyCodeError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
      default:
        return VerifyCodeFailure(
          status: SomeFailure.serverError(
            error: error,
            stack: stack,
            tag: '${ErrorText.verifyCodeFailure}(${ErrorText.serverError})',
            tagKey: ErrorText.exceptionsFolderKey,
            user: user,
            userSetting: userSetting,
          ),
        );
    }
    // return VerifyCodeFailure(
    //   status: SomeFailure.serverError(error: error, stack: stack),
    // );
  }

  final SomeFailure status;
}
