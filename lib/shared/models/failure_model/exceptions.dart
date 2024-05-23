import 'package:firebase_auth/firebase_auth.dart';
import 'package:kozak/shared/shared.dart';

/// COMMENT: Error handling classes
class SendFailure implements Exception {
  const SendFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SendFailure.fromCode(
    dynamic e,
  ) {
    switch (e) {
      default:
        return const SendFailure(SomeFailure.serverError());
    }
  }

  final SomeFailure status;
}

class GetFailur implements Exception {
  const GetFailur([
    this.status = const SomeFailure.initial(),
  ]);

  factory GetFailur.fromCode(
    dynamic e,
  ) {
    switch (e) {
      default:
        return const GetFailur(SomeFailure.serverError());
    }
  }

  final SomeFailure status;
}

/// {@template sign_up_with_email_and_password_failure}
/// Thrown during the sign up process if a failure occurs.
/// {@endtemplate}
class SignUpWithEmailAndPasswordFailure implements Exception {
  /// {@macro sign_up_with_email_and_password_failure}
  SignUpWithEmailAndPasswordFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SignUpWithEmailAndPasswordFailure.fromCode(
    FirebaseAuthException code,
  ) {
    switch (code.code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
          const SomeFailure.duplicate(),
        );
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
          const SomeFailure.serverError(),
        );
      case 'invalid-email':
      case 'user-disabled':
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
          const SomeFailure.notFound(),
        );
      default:
        return SignUpWithEmailAndPasswordFailure();
    }
  }

  final SomeFailure status;
}

class LogInWithEmailAndPasswordFailure implements Exception {
  /// {@macro log_in_with_email_and_password_failure}
  const LogInWithEmailAndPasswordFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(
    FirebaseAuthException code,
  ) {
    switch (code.code) {
      case 'user-disabled':
      case 'invalid-email':
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return const LogInWithEmailAndPasswordFailure(
          SomeFailure.notFound(),
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final SomeFailure status;
}

/// Thrown during the logout process if a failure occurs.
// class LogOutFailure implements Exception {}
class LogOutFailure implements Exception {
  const LogOutFailure([
    this.status = const SomeFailure.initial(),
  ]);

  final SomeFailure status;
}

class SignUpWithGoogleFailure implements Exception {
  const SignUpWithGoogleFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SignUpWithGoogleFailure.fromCode(FirebaseAuthException code) {
    switch (code.code) {
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
      default:
        return const SignUpWithGoogleFailure();
    }
  }

  final SomeFailure status;
}
