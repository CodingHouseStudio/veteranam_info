import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Error handling classes
class SendFailure {
  const SendFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SendFailure.fromCode(
    FirebaseException error,
  ) {
    debugPrint('SomeFailure: ${error.code}');
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
        return const SendFailure(SomeFailure.send());
      case 'network-error':
        return const SendFailure(SomeFailure.network());
      default:
        return const SendFailure(SomeFailure.serverError());
    }
  }

  final SomeFailure status;
}

class GetFailur {
  const GetFailur([
    this.status = const SomeFailure.initial(),
  ]);

  factory GetFailur.fromCode(
    FirebaseException error,
  ) {
    debugPrint('SomeFailure: ${error.code}');
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
        return const GetFailur(SomeFailure.get());
      case 'network-error':
        return const GetFailur(SomeFailure.network());
      default:
        return const GetFailur(SomeFailure.serverError());
    }
  }

  final SomeFailure status;
}

/// {@template sign_up_with_email_and_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure {
  /// {@macro sign_up_with_email_and_password_failure}
  const SignUpWithEmailAndPasswordFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(
    FirebaseAuthException error,
  ) {
    debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
          SomeFailure.duplicate(),
        );
      case 'operation-not-allowed':
      case 'invalid-email':
      case 'user-disabled':
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
          SomeFailure.serverError(),
        );
      case 'network-error':
        return const SignUpWithEmailAndPasswordFailure(SomeFailure.network());
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }

  final SomeFailure status;
}

class LogInWithEmailAndPasswordFailure {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(
    FirebaseAuthException error,
  ) {
    debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'user-disabled':
      case 'invalid-email':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure(
          SomeFailure.notFound(),
        );
      case 'network-error':
        return const LogInWithEmailAndPasswordFailure(SomeFailure.network());
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final SomeFailure status;
}

/// Thrown during the logout process if a failure occurs.
// class LogOutFailure  {}
class LogOutFailure {
  const LogOutFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory LogOutFailure.fromCode(
    FirebaseException error,
  ) {
    debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'missing-argument':
      case 'timeout':
      case 'canceled':
      case 'unauthenticated':
      case 'expired-token':
      case 'invalid-token':
      case 'user-not-found':
      case 'internal-error':
        return const LogOutFailure(SomeFailure.unauthorized());
      case 'network-error':
        return const LogOutFailure(SomeFailure.network());
      default:
        return const LogOutFailure(SomeFailure.serverError());
    }
  }

  final SomeFailure status;
}

class SignUpWithGoogleFailure {
  const SignUpWithGoogleFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SignUpWithGoogleFailure.fromCode(FirebaseAuthException error) {
    debugPrint('SomeFailure: ${error.code}');
    switch (error.code) {
      case 'account-exists-with-different-credential':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
      case 'user-disabled':
      case 'invalid-verification-code':
      case 'invalid-verification-id':
        return const SignUpWithGoogleFailure(
          SomeFailure.notFound(),
        );
      case 'operation-not-allowed':
        return const SignUpWithGoogleFailure(
          SomeFailure.serverError(),
        );
      case 'network-error':
        return const SignUpWithGoogleFailure(SomeFailure.network());
      default:
        return const SignUpWithGoogleFailure();
    }
  }

  final SomeFailure status;
}
