part of 'some_failure.dart';

extension SomeFailureExtension on SomeFailure? {
  bool get linkIsWrong => this == SomeFailure.linkWrong;
}
