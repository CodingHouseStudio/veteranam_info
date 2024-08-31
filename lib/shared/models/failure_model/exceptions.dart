import 'package:firebase_auth/firebase_auth.dart';
import 'package:veteranam/shared/shared.dart';

/// COMMENT: Error handling classes
class SendFailure {
  SendFailure({
    required this.status,
  });

  factory SendFailure.fromCode({
    required FirebaseException error,
    StackTrace? stack,
  }) {
    // debugPrint('SomeFailure: ${error.code}');
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
          status: SomeFailure.send(error: error, stack: stack),
        );
      case 'network-error':
        return SendFailure(
          status: SomeFailure.network(error: error, stack: stack),
        );
      default:
        return SendFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
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
  }) {
    // debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'missing-argument':
      case 'timeout':
      case 'canceled':
      case 'not-found':
      case 'permission-denied':
      case 'out-of-range':
      case 'data-error':
      case 'internal-error':
      case 'invalid-argument':
        return GetFailur(status: SomeFailure.get(error: error, stack: stack));
      case 'network-error':
        return GetFailur(
          status: SomeFailure.network(error: error, stack: stack),
        );
      default:
        return GetFailur(
          status: SomeFailure.serverError(error: error, stack: stack),
        );
    }
  }
  factory GetFailur.fromMessage({
    required Object error,
    StackTrace? stack,
  }) {
    if (error is TypeError) {
      return GetFailur(
        status: SomeFailure.serverError(error: error, stack: stack),
      );
    } else {
      return GetFailur(
        status: SomeFailure.serverError(error: error, stack: stack),
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
  }) {
    // debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.duplicate(error: error, stack: stack),
        );
      case 'operation-not-allowed':
      case 'invalid-email':
      case 'user-disabled':
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
        );
      case 'network-error':
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.network(error: error, stack: stack),
        );
      default:
        return SignUpWithEmailAndPasswordFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
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
  }) {
    // debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'user-disabled':
      case 'invalid-email':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return LogInWithEmailAndPasswordFailure(
          status: SomeFailure.notFound(error: error, stack: stack),
        );
      case 'network-error':
        return LogInWithEmailAndPasswordFailure(
          status: SomeFailure.network(error: error, stack: stack),
        );
      default:
        return LogInWithEmailAndPasswordFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
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
  }) {
    // debugPrint('SomeFailure: ${error.code}');
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
          status: SomeFailure.unauthorized(error: error, stack: stack),
        );
      case 'network-error':
        return LogOutFailure(
          status: SomeFailure.network(error: error, stack: stack),
        );
      default:
        return LogOutFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
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
  }) {
    // debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'account-exists-with-different-credential':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'user-disabled':
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return SignUpWithGoogleFailure(
          status: SomeFailure.notFound(error: error, stack: stack),
        );
      case 'operation-not-allowed':
        return SignUpWithGoogleFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
        );
      case 'network-error':
        return SignUpWithGoogleFailure(
          status: SomeFailure.network(error: error, stack: stack),
        );
      default:
        return SignUpWithGoogleFailure(
          status: SomeFailure.serverError(error: error, stack: stack),
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
  }) {
    // debugPrint('SomeFailure: ${error.code}');
    if (error is Exception) {
      switch (error.toString()) {
        case 'Exception: Navigator.canShare() is unavailable':
          return const ShareFailure(
            status: null,
          );
        default:
          return ShareFailure(
            status: SomeFailure.share(error: error, stack: stack),
          );
      }
    } else {
      return ShareFailure(
        status: SomeFailure.serverError(error: error, stack: stack),
      );
    }
  }

  final SomeFailure? status;
}
