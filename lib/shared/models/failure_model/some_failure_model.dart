import 'package:freezed_annotation/freezed_annotation.dart';

part 'some_failure_model.freezed.dart';

@freezed
class SomeFailure with _$SomeFailure {
  const factory SomeFailure.initial() = _Initial;

  const factory SomeFailure.serverError() = _ServerError;
}
