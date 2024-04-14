import 'package:kozak/shared/shared.dart';

/// COMMENT: Error handling classes
class SendFailure implements Exception {
  const SendFailure([
    this.status = const SomeFailure.initial(),
  ]);

  factory SendFailure.fromCode(
    Exception e,
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
    Exception e,
  ) {
    switch (e) {
      default:
        return const GetFailur(SomeFailure.serverError());
    }
  }

  final SomeFailure status;
}
